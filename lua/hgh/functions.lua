local Path = require('plenary.path')
local F = {}

function F.bufferdir()
  -- Get the full path of the current buffer
  local path = vim.fn.expand('%:p')

  -- Check if the path is a directory
  local stat = vim.loop.fs_stat(path)
  if stat and stat.type == 'directory' then
    return path
  else
    -- Otherwise, return the directory part of the path
    return Path:new(vim.fn.expand('%:p')):parent():absolute()
  end
end

function F.findgitdir(directory)
  local gitDir = Path:new(directory):joinpath('.git'):absolute()
  local parentDir = Path:new(directory):parent():absolute()

  if vim.loop.fs_stat(gitDir) then
    -- Found the .git directory
    return directory
  elseif directory == parentDir then
    -- Reached the filesystem root without finding a .git directory
    return nil
  else
    -- Recurse into the parent directory
    return F.findgitdir(parentDir)
  end
end

return F
