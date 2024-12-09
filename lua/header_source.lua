local M = {}

local Dfile

local function open_debug()
  if not Dfile then
    Dfile = io.open('header_source.log', 'w')
  end
end

local function debug(msg)
  if Dfile then
    Dfile:write(msg .. '\n')
  end
end

local function close()
  if Dfile then
    Dfile:close()
  end
end

M.setup = function()
  vim.keymap.set('n', '<leader>h', function()
    -- open_debug()
    local api = vim.api
    -- Get the current buffer name and extension
    local bufname = api.nvim_buf_get_name(0)
    local extension = bufname:match '%.(%w+)$'
    local cwd = vim.fn.getcwd()
    -- print(bufname)
    -- print(extension)
    -- Set search_file_name to current buffer name and change extension if necessary
    local search_file_name
    if extension == 'c' then
      search_file_name = bufname:gsub('%.(c)$', '.h')
    elseif extension == 'cpp' then
      search_file_name = bufname:gsub('%.(cpp)$', '.h')
    elseif extension == 'h' then
      search_file_name = bufname:gsub('%.(h)$', '.c')
    else
      -- close()
      return
    end

    local dir_path = string.match(search_file_name, '(.*/)')
    local file_name = string.match(search_file_name, '[^/]*$')

    -- debug('cwd: ' .. cwd .. '\n')
    -- debug('dir_path: ' .. dir_path .. '\n')
    -- debug('file_name: ' .. file_name .. '\n')

    -- Split the path into parts based on the '/' delimiter
    local parts = {}
    for part in dir_path:gmatch '[^/]+' do
      table.insert(parts, part)
    end

    -- Get the last part of the path
    local lastPart = parts[#parts]

    local parent_folder = dir_path
    if lastPart == 'include' or lastPart == 'source' or lastPart == 'src' then
      -- Extract parent folder of dir_path
      parent_folder = string.match(dir_path:sub(1, -1), '(.*/).*/')
    end

    local b_file_name = '/' .. file_name

    -- debug 'searching in buffers...'

    for _, buffer in ipairs(api.nvim_list_bufs()) do
      local bufname = api.nvim_buf_get_name(buffer)
      -- debug('bufname: ' .. bufname .. '\n')
      if bufname:find(b_file_name, 1, true) then
        vim.api.nvim_set_current_buf(buffer)
        -- close()
        return
      end
    end

    local cmd = 'fdfind -g -t f "' .. file_name .. '" ' .. parent_folder
    -- debug(cmd)
    local result = vim.fn.systemlist(cmd)
    -- debug('result length: ' .. #result)
    if not (#result == 1) then
      -- debug 'retrying...'
      cmd = 'fdfind -g -t f "' .. file_name .. '" '
      result = vim.fn.systemlist(cmd)
      if not (#result == 1) then
        -- debug 'not found'
        -- close()
        return
      end
    end
    for _, file in ipairs(result) do
      -- print (file)
      vim.api.nvim_command('edit ' .. file)
    end
  end, { noremap = true, silent = true })
end

return M
