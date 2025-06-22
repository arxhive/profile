local M = {}

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
    if cursor_line >= block.start and cursor_line <= block.ending then
      -- We're in this block, find the next one
      for i, next_block in ipairs(blocks) do
        if next_block.start > block.ending then
          target_block = next_block
          break
        end
      end
      break
    elseif block.start > cursor_line then
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
    if cursor_line >= block.start and cursor_line <= block.ending then
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
      if blocks[i].ending < cursor_line then
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
      LazyVim.notify("File already exists: " .. filepath, { level = "warn" })
      return
    end

    -- Create directory structure if needed
    local dir = vim.fn.fnamemodify(filepath, ":h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end

    -- Create the empty file
    vim.fn.writefile({}, filepath)
    LazyVim.notify("Created file: " .. filepath, { level = "info" })
  else
    LazyVim.notify("No file path found in current line", { level = "error" })
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
        LazyVim.notify("File already exists: " .. filepath, { level = "warn" })
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

  LazyVim.notify("Created " .. files_created .. " files and " .. dirs_created .. " directories", { level = "info" })
end

-- Copy snippet to a new defined file
function M.insert_to_new_file()
  local cursor_line = vim.fn.line(".")
  local filename = nil
  local is_fenced, head, tail = Tricks.get_fenced()

  if not is_fenced then
    return
  end

  -- Get the line above the block to find filename
  -- expected file format:
  -- [file:msi-connector/cmd/token_strategies/helpers.go](msi-connector/cmd/token_strategies/helpers.go) line:1-15
  local potential_filename_line = vim.fn.getline(head - 3)
  -- If the line above is blank, try the line before that
  if potential_filename_line == "" then
    potential_filename_line = vim.fn.getline(head - 2)
  end

  -- Try to extract filename from markdown link format: [file:name](path)
  filename = potential_filename_line:match("%[file:[^%]]+%]%(([^%)]+)%)")

  -- If not found, try to extract the last word in the line as a fallback
  if not filename then
    filename = potential_filename_line:match("(%S+)%s*$")
  end

  if not filename then
    vim.notify("No filename found in line above code block", vim.log.levels.WARN, { title = "Markdown" })
    return
  end

  -- Get the code block content (exclude the fence markers)
  local content = vim.api.nvim_buf_get_lines(0, head, tail, false)

  -- Remove the language identifier from the first line if present
  if #content > 0 and content[1]:match("^%w+$") then
    table.remove(content, 1)
  end

  -- Create directory structure if needed
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
      LazyVim.notify("Appended to: " .. filename, { level = "info" })
    end
  else
    -- Create new file with content
    vim.fn.writefile(content, filename)
    LazyVim.notify("Created new file: " .. filename, { level = "info" })
  end
end

return M
