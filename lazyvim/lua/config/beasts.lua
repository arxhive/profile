local M = {}

-- Next fenced snippet in markdown
function M.next_fenced()
  local start_pattern = "^```%S*$" -- Match opening fence with any language
  local end_pattern = "^```$" -- Match closing fence
  local cursor_line = vim.fn.line(".")
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local found_line = nil
  local in_block = false

  -- Check if we're currently inside a block
  for i = cursor_line, 1, -1 do
    if content[i]:match(start_pattern) then
      in_block = true
      break
    elseif content[i]:match(end_pattern) then
      break
    end
  end

  -- Search strategy depends on whether we're in a block
  if in_block then
    -- Find the end of current block first
    for i = cursor_line, #content do
      if content[i]:match(end_pattern) then
        -- Then find the start of the next block
        for j = i + 1, #content do
          if content[j]:match(start_pattern) then
            found_line = j + 1 -- Jump to first line inside block
            break
          end
        end
        break
      end
    end
  else
    -- Not in a block, find the next block start
    for i = cursor_line + 1, #content do
      if content[i]:match(start_pattern) then
        found_line = i + 1 -- Jump to first line inside block
        break
      end
    end
  end

  if found_line and found_line <= #content then
    vim.api.nvim_win_set_cursor(0, { found_line, 0 })
  else
    LazyVim.notify("No next code block found", { title = "Markdown", level = "warn" })
  end
end

-- Previous fenced snippet in markdown
function M.previous_fenced()
  local start_pattern = "^```$" -- Match opening fence with any language
  local end_pattern = "^```$" -- Match closing fence
  local cursor_line = vim.fn.line(".")
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local found_line = nil

  -- Determine if we're inside a code block
  local in_block = false
  local current_block_start = nil

  -- Check if we're inside a block by looking upward for start/end patterns
  for i = cursor_line, 1, -1 do
    if content[i]:match(start_pattern) then
      in_block = true
      current_block_start = i
      break
    elseif content[i]:match(end_pattern) then
      -- Found end pattern before start pattern, so we're not in a block
      break
    end
  end

  local search_start_line = in_block and (current_block_start - 1) or cursor_line

  -- Step 1: Find the closest end_pattern above our search start position
  local closest_end = nil
  for i = search_start_line, 1, -1 do
    if content[i]:match(end_pattern) then
      closest_end = i
      break
    end
  end

  -- Step 2: If we found an end_pattern, look for the corresponding start_pattern
  if closest_end then
    for i = closest_end - 1, 1, -1 do
      if content[i]:match(start_pattern) then
        found_line = i + 1 -- Jump to first line inside block
        break
      end
    end
  end

  if found_line and found_line > 0 and found_line <= #content then
    vim.api.nvim_win_set_cursor(0, { found_line, 0 })
  else
    LazyVim.notify("No previous code block found", { title = "Markdown", level = "warn" })
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

return M
