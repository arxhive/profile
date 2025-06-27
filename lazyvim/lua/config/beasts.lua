local M = {}

function M.select_fenced()
  -- Exit visual mode to ensure we're in normal mode to count line positions properly
  -- The `'nx'` mode parameter means "no mapping" (like `normal!`)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)

  local is_fenced, head, tail = Tricks.get_fenced()

  -- Visually select the code content (excluding the opening fence, including the content up to the closing fence)
  if is_fenced then
    -- Move to first content line (line after the opening fence)
    vim.api.nvim_win_set_cursor(0, { head, 0 })
    -- Start visual line mode
    vim.cmd("normal! V")
    -- Extend selection to the line before the closing fence
    vim.api.nvim_win_set_cursor(0, { tail, 0 })
  end
end

function M.yank_fenced()
  M.select_fenced()
  vim.api.nvim_feedkeys("y", "n", true)
  vim.schedule(function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  end)
  -- vim.api.nvim_command("nohl") -- Clear search highlights after yanking

  -- Alternative implementation, no visual highlights
  -- local is_fenced, head, tail = Tricks.get_fenced()
  --
  -- -- Yank the content if inside a fenced block
  -- if is_fenced then
  --   -- Store the current cursor position to restore later
  --   local cursor_pos = vim.api.nvim_win_get_cursor(0)
  --
  --   local content = vim.api.nvim_buf_get_lines(0, head, tail, false)
  --   -- Join the lines with newline characters for the system clipboard
  --   local content_str = table.concat(content, "\n")
  --
  --   -- Set the content to the system clipboard (+ register)
  --   vim.schedule(function()
  --     vim.fn.setreg("+", content_str, "c") -- Use the + register for system clipboard
  --   end)
  --
  --   -- Restore cursor position
  --   vim.api.nvim_win_set_cursor(0, cursor_pos)
  --
  --   LazyVim.notify("Yanked fenced: " .. tail - head + 1)
  -- end
end

-- Helper function to collect all fenced code blocks in a buffer
local function collect_fenced_blocks()
  local start_pattern = "^```%S*$" -- Match opening fence with any language
  local end_pattern = "^```$" -- Match closing fence
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Collect all code blocks
  local blocks = {}
  local current_start = nil

  for i = 1, #content do
    if content[i]:match(start_pattern) and current_start == nil then
      current_start = i
    elseif content[i]:match(end_pattern) and current_start ~= nil then
      table.insert(blocks, { start = current_start, ending = i })
      current_start = nil
    end
  end

  return blocks
end

-- Next fenced snippet in markdown
function M.next_fenced()
  local cursor_line = vim.fn.line(".")
  local blocks = collect_fenced_blocks()

  -- Find the appropriate next block based on cursor position
  local target_block = nil

  -- Check if cursor is inside a block
  for _, block in ipairs(blocks) do
    if cursor_line > block.start and cursor_line <= block.ending then
      -- We're in this block, find the next one
      for i, next_block in ipairs(blocks) do
        if next_block.start > block.ending then
          target_block = next_block
          break
        end
      end
      break
    elseif block.start >= cursor_line then
      -- This is the first block after cursor
      target_block = block
      break
    end
  end

  if target_block then
    vim.api.nvim_win_set_cursor(0, { target_block.start + 1, 0 }) -- Jump to first line inside block
  else
    vim.notify("No next code block found", vim.log.levels.WARN, { title = "Markdown" })
  end
end

-- Previous fenced snippet in markdown
function M.previous_fenced()
  local cursor_line = vim.fn.line(".")
  local blocks = collect_fenced_blocks()

  -- Find the appropriate previous block based on cursor position
  local target_block = nil

  -- Check if cursor is inside a block
  local current_block = nil
  for _, block in ipairs(blocks) do
    if cursor_line >= block.start and cursor_line < block.ending then
      current_block = block
      break
    end
  end

  if current_block then
    -- Find the previous block
    for i = #blocks, 1, -1 do
      if blocks[i].ending < current_block.start then
        target_block = blocks[i]
        break
      end
    end
  else
    -- Not in a block, find the closest previous block
    for i = #blocks, 1, -1 do
      if blocks[i].ending <= cursor_line then
        target_block = blocks[i]
        break
      end
    end
  end

  if target_block then
    vim.api.nvim_win_set_cursor(0, { target_block.start + 1, 0 }) -- Jump to first line inside block
  else
    vim.notify("No previous code block found", vim.log.levels.WARN, { title = "Markdown" })
  end
end

-- Get text from the current line
function M.touch_from_filename()
  local line = vim.fn.getline(".")
  -- Extract file path using pattern matching
  local filepath = line:match("%[file:([^%]]+)%]")
  if filepath then
    -- Check if file already exists
    if vim.fn.filereadable(filepath) == 1 then
      LazyVim.info("File already exists: " .. filepath)
      return
    end

    -- Create directory structure if needed
    local dir = vim.fn.fnamemodify(filepath, ":h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end

    -- Create the empty file
    vim.fn.writefile({}, filepath)
    LazyVim.info("Created file: " .. filepath)
  else
    LazyVim.info("No file path found in current line")
  end
end

function M.touch_from_tree()
  -- Get all lines in the current paragraph (blank line separated)
  local line_nr = vim.fn.line(".")
  local start_line = line_nr
  local end_line = line_nr

  -- Check if we're in a code block
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local in_code_block = false
  local code_block_start = nil

  -- Check if current line is in a code block by looking for markers
  for i = line_nr, 1, -1 do
    if content[i]:match("^```%S*$") then
      in_code_block = true
      code_block_start = i
      break
    elseif content[i]:match("^```$") then
      -- Found end pattern before start pattern, so we're not in a block
      break
    end
  end

  if in_code_block then
    -- We're in a code block, find its end
    for i = line_nr, #content do
      if content[i]:match("^```$") then
        start_line = code_block_start + 1
        end_line = i - 1
        break
      end
    end
  else
    -- Regular paragraph boundaries detection
    -- Find start of the block by going up until empty line or start of file
    while start_line > 1 and vim.fn.trim(vim.fn.getline(start_line - 1)) ~= "" do
      start_line = start_line - 1
    end

    -- Find end of the block by going down until empty line or end of file
    while end_line < vim.fn.line("$") and vim.fn.trim(vim.fn.getline(end_line + 1)) ~= "" do
      end_line = end_line + 1
    end
  end

  -- Extract the lines in the block
  local lines = vim.fn.getline(start_line, end_line)
  local cwd = vim.fn.getcwd() .. "/"
  local relative_dir = ""
  local files_created = 0
  local current_dir_path = {}
  local indent_level_dirs = {}

  -- Process each line
  for i, line in ipairs(lines) do
    -- Extract directory name from the first line (assuming root directory is first)
    if i == 1 and not line:match("^[├└│]") then
      -- Extract the path but remove comments (everything after #)
      relative_dir = line:gsub("#.*$", ""):gsub("%s*$", "") -- Remove comments and trailing whitespace
      -- If it doesn't end with slash, add one
      if not relative_dir:match("/$") then
        relative_dir = relative_dir .. "/"
      end
      -- Set up the root directory in the current path
      current_dir_path = { relative_dir }
    else
      -- Calculate the indentation level
      local indent_level = 0
      local indent = line:match("^%s+")
      if indent then
        indent_level = math.floor(#indent / 2)
      end

      -- Handle directory entries (ending with / or having subdirectories below)
      if line:match("/[%s#]*$") or line:match("│") then
        -- This is a directory
        local dir_name = line:match("[├└]%s+([^#]+)"):gsub("%s*$", "")

        -- If directory name doesn't end with slash, add one
        if not dir_name:match("/$") then
          dir_name = dir_name .. "/"
        end

        -- Adjust current directory path based on indentation
        while #current_dir_path > indent_level + 1 do
          table.remove(current_dir_path)
        end

        table.insert(current_dir_path, dir_name)
        indent_level_dirs[indent_level + 1] = dir_name

        -- Create the directory
        local dir_path = cwd .. table.concat(current_dir_path, "")
        if vim.fn.isdirectory(dir_path) == 0 then
          vim.fn.mkdir(dir_path, "p")
        end
      else
        -- Match file paths with more flexible pattern
        -- Look for ├── or └── followed by a filename
        local is_file_line = line:match("[├└]")
        if is_file_line then
          -- Expected format including a comment: ├── interface.go      # Defines the common strategy interface
          local file_parts = vim.split(line:gsub("^%s+", ""), "%s+")
          local filename = file_parts[2]

          if filename and not filename:match("/$") then
            -- Adjust current directory path based on indentation
            while #current_dir_path > indent_level + 1 do
              table.remove(current_dir_path)
            end

            -- Consider filename without extension as directory if it doesn't contain a period
            if not filename:match("%.") then
              -- Treat as directory
              local dir_name = filename .. "/"
              table.insert(current_dir_path, dir_name)

              -- Create the directory
              local dir_path = cwd .. table.concat(current_dir_path, "")
              if vim.fn.isdirectory(dir_path) == 0 then
                LazyVim.info("Creating directory: " .. dir_path)
                vim.fn.mkdir(dir_path, "p")
              end
            else
              -- It's a file
              local filepath = cwd .. table.concat(current_dir_path, "") .. filename
              LazyVim.info("Processing file: " .. filepath)

              -- Check if file already exists
              if vim.fn.filereadable(filepath) == 1 then
                LazyVim.notify("File already exists: " .. filepath, { level = "warn" })
              else
                -- Create directory structure if needed
                local dir = vim.fn.fnamemodify(filepath, ":h")
                if vim.fn.isdirectory(dir) == 0 then
                  LazyVim.info("Creating directory: " .. dir)
                  vim.fn.mkdir(dir, "p")
                end
                -- Create the empty file
                vim.fn.writefile({}, filepath)
                LazyVim.notify("Created file: " .. filepath, { level = "info" })
                files_created = files_created + 1
              end
            end
          end
        else
          LazyVim.info("No file pattern in line: " .. line)
        end
      end
    end
  end

  LazyVim.info("Process complete. Files created: " .. files_created)

  if files_created == 0 then
    LazyVim.notify("No files created from tree structure", { level = "warn" })
  else
    LazyVim.notify("Created " .. files_created .. " files", { level = "info" })
  end
end

function M.touch_from_filename_list()
  -- Get all lines in the current selection or current block
  local line_nr = vim.fn.line(".")
  local start_line, end_line = line_nr, line_nr

  -- Find start and end of the block with file paths
  local blocks = collect_fenced_blocks()
  local in_code_block = false

  -- Check if we're in a code block
  for _, block in ipairs(blocks) do
    if line_nr >= block.start and line_nr <= block.ending then
      start_line = block.start + 1 -- Skip the opening ```
      end_line = block.ending - 1 -- Skip the closing ```
      in_code_block = true
      break
    end
  end

  if not in_code_block then
    -- For regular text, find paragraph bounds
    while start_line > 1 and vim.fn.trim(vim.fn.getline(start_line - 1)) ~= "" do
      start_line = start_line - 1
    end

    while end_line < vim.fn.line("$") and vim.fn.trim(vim.fn.getline(end_line + 1)) ~= "" do
      end_line = end_line + 1
    end
  end

  -- Get the file paths
  local filepaths = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local cwd = vim.fn.getcwd() .. "/"
  local files_created = 0
  local dirs_created = 0

  -- Process each file path
  for _, filepath in ipairs(filepaths) do
    filepath = vim.fn.trim(filepath)
    if filepath ~= "" then
      -- Check if file already exists
      if vim.fn.filereadable(filepath) == 1 then
        LazyVim.info("File already exists: " .. filepath)
      else
        -- Create directory structure if needed
        local dir = vim.fn.fnamemodify(filepath, ":h")
        if vim.fn.isdirectory(dir) == 0 then
          vim.fn.mkdir(dir, "p")
          dirs_created = dirs_created + 1
        end

        -- Create the empty file
        vim.fn.writefile({}, filepath)
        files_created = files_created + 1
      end
    end
  end

  LazyVim.info("Created " .. files_created .. " files and " .. dirs_created .. " directories")
end

-- try to get the filename for a fenced block
function M.filename_header_for_fenced()
  local filename = nil
  local is_fenced, head, tail = Tricks.get_fenced()

  if not is_fenced then
    return nil
  end

  -- Get the line above the block to find filename
  -- expected file format:
  -- [file:msi-connector/cmd/token_strategies/helpers.go](msi-connector/cmd/token_strategies/helpers.go) line:1-15
  local potential_filename_line = vim.fn.getline(head - 2)
  -- If the line above is blank, try the line before that
  if potential_filename_line == "" then
    potential_filename_line = vim.fn.getline(head - 3)
  end

  -- Try to extract filename from markdown link format: [file:name](path)
  filename = potential_filename_line:match("%[file:[^%]]+%]%(([^%)]+)%)")
  if filename == nil or filename == "" then
    LazyVim.info("No filename header found, line: " .. head)
    return nil
  end

  return filename
end

-- combine header with cwd or root directory to get a full path
function M.live_file_for_fenced()
  local filename = M.filename_header_for_fenced()
  if not filename then
    return nil
  end

  -- If filename starts with "/" it's an absolute path
  if filename:sub(1, 1) == "/" then
    if vim.fn.filereadable(vim.fn.expand(filename)) == 1 then
      Tricks.inspect(filename)
      return filename
    else
      LazyVim.info("Absolute path not found: " .. filename)
      return nil
    end
  end

  -- Try multiple path combinations for relative paths
  local root = Tricks.rootdir()
  local cwd = vim.fn.getcwd()
  local paths_to_try = {
    root .. "/" .. filename, -- Try from root
    cwd .. "/" .. filename, -- Try from cwd
  }

  for _, path in ipairs(paths_to_try) do
    if vim.fn.filereadable(vim.fn.expand(path)) == 1 then
      Tricks.inspect(path)
      return path
    end
  end

  LazyVim.info("File not found: " .. filename)
  return nil
end

-- try to get the lines for a filename in the fenced block
function M.lines_for_fenced()
  local is_fenced, head, _ = Tricks.get_fenced()

  if not is_fenced then
    return nil, nil
  end

  -- Get the line above the block to find filename
  -- expected file format:
  -- [file:msi-connector/cmd/token_strategies/helpers.go](msi-connector/cmd/token_strategies/helpers.go) line:1-15
  local potential_filename_line = vim.fn.getline(head - 2)
  -- If the line above is blank, try the line before that
  if potential_filename_line == "" then
    potential_filename_line = vim.fn.getline(head - 3)
  end

  -- Try to extract line numbers from the format: line:631-634 or line:631
  local start_line, end_line = potential_filename_line:match("line:(%d+)%-(%d+)")
  if not start_line then
    -- Try single line format: line:631
    start_line = potential_filename_line:match("line:(%d+)")
    end_line = start_line
  end

  return start_line and tonumber(start_line) or nil, end_line and tonumber(end_line) or nil
end

-- insert to a new file or append to an existing one
function M.new_file_or_append()
  local is_fenced, head, tail = Tricks.get_fenced()
  local filename = M.live_file_for_fenced()

  if not filename then
    LazyVim.info("No filename found in line above code block, skip")
    return false
  end

  -- Get the code block content (exclude the fence markers)
  local content = vim.api.nvim_buf_get_lines(0, head, tail, false)

  -- Create directory structure for the file if needed
  local dir = vim.fn.fnamemodify(filename, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end

  -- Check if file exists and append content if it does
  if vim.fn.filereadable(filename) == 1 then
    local file = io.open(filename, "a")
    if file then
      file:write("\n")
      file:write(table.concat(content, "\n"))
      file:close()
      LazyVim.info("Appended to: " .. filename)
      return true
    end
  else
    -- Create new file with content
    vim.fn.writefile(content, filename)
    LazyVim.info("Created new file: " .. filename)
    return true
  end
end

-- skip if file already exists
function M.try_a_new_file()
  local is_fenced, head, tail = Tricks.get_fenced()
  local filename = M.filename_header_for_fenced()

  if not filename then
    return false
  end

  -- Get the code block content (exclude the fence markers)
  local content = vim.api.nvim_buf_get_lines(0, head, tail, false)

  -- Create directory structure for the file if needed
  local dir = vim.fn.fnamemodify(filename, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end

  -- Check if file exists and append content if it does
  if vim.fn.filereadable(filename) ~= 1 then
    -- Create new file with content
    vim.fn.writefile(content, filename)
    LazyVim.info("Created new file: " .. filename)
    return true
  end

  return false
end

function M.insert_many_fenced_to_files()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local start_marker = nil
  local end_marker = nil

  -- Find the last "#### in" marker
  for i = #content, 1, -1 do
    if content[i]:match("^#### in") then
      start_marker = i
      break
    end
  end

  -- Find the last "## out" marker before the start marker
  if start_marker then
    for i = start_marker, 1, -1 do
      if content[i]:match("^## out") then
        end_marker = i
        break
      end
    end
  end

  -- If we found both markers, process the blocks between them
  if start_marker and end_marker then
    -- Store the current cursor position
    local original_cursor = vim.api.nvim_win_get_cursor(0)

    -- Move to the start line
    vim.api.nvim_win_set_cursor(0, { start_marker - 1, 0 })

    -- Process each fenced block in the section
    local blocks = collect_fenced_blocks()
    local blocks_processed = 0

    -- Filter blocks to only include those between start_line and end_line
    local session_blocks = {}
    for _, block in ipairs(blocks) do
      if block.start > end_marker and block.ending < start_marker then
        table.insert(session_blocks, block)
      end
    end

    -- Process each block
    for _, block in ipairs(session_blocks) do
      -- Move to the block
      vim.api.nvim_win_set_cursor(0, { block.start + 1, 0 })
      -- Insert the block to a new file
      local success = M.new_file_or_append()
      if success then
        blocks_processed = blocks_processed + 1
      end
    end

    -- Restore original cursor position
    vim.api.nvim_win_set_cursor(0, original_cursor)

    LazyVim.info("Accepted " .. blocks_processed .. " proposed changes")
  else
    LazyVim.error("Could not find '#### in' and '## out' markers")
  end
end

function M.copilot_chat_accept_all()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local start_marker = nil
  local end_marker = nil

  -- Find the last "#### in" marker
  for i = #content, 1, -1 do
    if content[i]:match("^#### in") then
      start_marker = i
      break
    end
  end

  -- Find the last "## out" marker before the start marker
  if start_marker then
    for i = start_marker, 1, -1 do
      if content[i]:match("^## out") then
        end_marker = i
        break
      end
    end
  end

  -- If we found both markers, process the blocks between them
  if start_marker and end_marker then
    -- Store the current cursor position
    local original_cursor = vim.api.nvim_win_get_cursor(0)

    -- Move to the start line
    vim.api.nvim_win_set_cursor(0, { start_marker - 1, 0 })

    -- Process each fenced block in the section
    local blocks = collect_fenced_blocks()
    local blocks_processed = 0
    local created = 0
    local updated = 0
    local blinders = 0 -- diff without a filename header

    -- Filter blocks to only include those between start_line and end_line
    local session_blocks = {}
    for _, block in ipairs(blocks) do
      if block.start > end_marker and block.ending < start_marker then
        table.insert(session_blocks, block)
      end
    end

    -- Process each block
    local copilot = require("CopilotChat")
    for _, block in ipairs(session_blocks) do
      -- Move to the block
      vim.api.nvim_win_set_cursor(0, { block.start + 1, 0 })

      -- Handle new files
      local success = M.try_a_new_file()
      if success then
        created = created + 1
      -- Or update existing file using copilot-chat native tools
      else
        local filename = M.live_file_for_fenced()
        if filename then
          vim.api.nvim_command("wincmd h") -- move to left window to activate a file a new buffer
          -- Open the file in a buffer first
          vim.cmd("edit " .. vim.fn.fnameescape(filename))
          -- Jump back to the chat buffer
          vim.cmd("wincmd p")

          copilot.config.mappings.accept_diff.callback(copilot.get_source())

          vim.api.nvim_command("wincmd h") -- move to back to buffer to save changes
          vim.cmd("w")
          vim.cmd("wincmd p")

          updated = updated + 1

        -- blindly accept any change without filename header
        else
          copilot.config.mappings.accept_diff.callback(copilot.get_source())
          blinders = blinders + 1
        end
      end

      LazyVim.info("Accept on line: " .. block.start + 1)
      blocks_processed = blocks_processed + 1
    end

    -- Restore original cursor position
    vim.api.nvim_win_set_cursor(0, original_cursor)

    LazyVim.info("Copilot diff work:\nFiles created: " .. created .. "\nHunks updated: " .. updated .. "\nBlinders: " .. blinders .. "\nAccepted total: " .. blocks_processed)
    require("noice").cmd("messages")
  else
    LazyVim.error("Could not find '#### in' and '## out' markers")
  end
end

function M.jump_to_lines()
  local filename = M.live_file_for_fenced()
  if filename then
    local start_line, end_line = M.lines_for_fenced()
    vim.api.nvim_command("wincmd h") -- move to left window to activate a file a new buffer
    vim.api.nvim_command("edit " .. filename)

    if start_line then
      -- Jump to the specified lines
      vim.api.nvim_win_set_cursor(0, { start_line, 0 })
      if end_line and end_line ~= start_line then
        vim.cmd("normal! V")
        vim.api.nvim_win_set_cursor(0, { end_line, 0 })
      end
    else
      LazyVim.error("No lines specified for the fenced block")
    end
  end
end

function M.git_show()
  -- 1. Get file type of the current file
  local filetype = vim.bo.filetype

  -- 2. Get current file path relative to git repo
  local full_path = vim.fn.expand("%:p")
  local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")

  if vim.v.shell_error ~= 0 then
    LazyVim.error("Not in a git repository")
    return
  end

  -- Get relative path from git root
  local filename = full_path:sub(#git_root + 2) -- +2 to skip the trailing slash

  -- 3. Execute git show and copy to clipboard
  local show_cmd = string.format('git show "$(git rev-parse --abbrev-ref HEAD):%s" | pbcopy', filename)
  local result = vim.fn.system(show_cmd)

  if vim.v.shell_error ~= 0 then
    LazyVim.error("Failed to get file from git: " .. result)
    return
  end

  -- Get the clipboard content directly
  local content = vim.fn.getreg("+")

  M.readmode(content, filetype)
end

function M.readmode(content, filetype)
  -- Create a new buffer with minimal height
  vim.cmd("new")
  vim.cmd("resize 0 | vertical resize 0")

  -- Set the filetype for the new buffer
  vim.bo.filetype = filetype

  -- Set it in the buffer
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n", { plain = true }))

  -- Store buffer number for cleanup
  local bufnr = vim.api.nvim_get_current_buf()

  -- Map 'q' to close zen mode, close window, and delete buffer
  vim.keymap.set("n", "q", function()
    -- require("snacks").zen.close()
    vim.cmd("close")
    vim.cmd("bdelete! " .. bufnr)
  end, { buffer = bufnr, nowait = true, silent = true })

  -- Execute Zen mode
  local ok, snacks = pcall(require, "snacks")
  if ok and snacks.zen then
    vim.schedule(function()
      snacks.zen.zen({ toggles = { dim = false } })
    end)
  else
    LazyVim.error("Snacks.zen not available")
  end
end

return M
