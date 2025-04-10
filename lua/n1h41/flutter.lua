local status, flutter_dev_tools = pcall(require, "flutter-tools.dev_tools")
if not status then
  vim.notify("flutter-tools.nvim not found.")
  return
end

local utils = require("flutter-tools.utils")

local function splitUrl(url)
  local parts = {}
  for part in url:gmatch("[^?]+") do
    table.insert(parts, part)
  end
  return parts
end

local M = {}

function M.convert_class_name_to_model_class_name()
  local word = vim.fn.expand("<cword>")
  local strippedWord = word:gsub("Entity", "")
  local pattern = "\\v(_\\$|\\<)?(" .. word .. ")(\\s|\\;|\\.|FromJson|\\(|\\>|\\?)"
  local replacement = "\\1" .. strippedWord .. "Model\\3"
  vim.cmd("%s/" .. pattern .. "/" .. replacement .. "/g")
  vim.notify("Converted class name: " .. word .. " --> " .. word .. "Model")
end

function M.convert_class_name_to_entity_class_name()
  local word = vim.fn.expand("<cword>")
  local strippedWord = word:gsub("Model", "")
  local pattern = "\\v(_\\$|\\<)?(" .. word .. ")(\\s|\\;|\\.|FromJson|\\(|\\>|\\?)"
  local replacement = "\\1" .. strippedWord .. "Entity\\3"
  vim.cmd("%s/" .. pattern .. "/" .. replacement .. "/g")
  vim.notify("Converted class name: " .. word .. " --> " .. word .. "Entity")
end

function M.open_network_tab()
  -- split at before the first question mark
  local profiler_url = flutter_dev_tools.get_profiler_url()
  if profiler_url == nil then
    vim.notify("profiler_url is nil")
    return
  end
  -- split string
  local parts = splitUrl(profiler_url)
  --[[ for part in profiler_url:gmatch("[^?]+") do
    table.insert(parts, part)
  end ]]
  local url = parts[1]
  local query = parts[2]
  -- insert the string 'network' between the url and the query
  local network_tab_url = url .. "network?" .. query
  vim.notify("Opening network tab: " .. network_tab_url)
  vim.fn.jobstart({ utils.open_command(), network_tab_url }, { detach = true })
end

function M.open_debugger_tab()
  -- split at before the first question mark
  local profiler_url = flutter_dev_tools.get_profiler_url()
  if profiler_url == nil then
    vim.notify("profiler_url is nil")
    return
  end
  -- split string
  local parts = splitUrl(profiler_url)
  --[[ for part in profiler_url:gmatch("[^?]+") do
    table.insert(parts, part)
  end ]]
  local url = parts[1]
  local query = parts[2]
  -- insert the string 'debugger' between the url and the query
  local debugger_tab_url = url .. "debugger?" .. query
  vim.notify("Opening debugger tab: " .. debugger_tab_url)
  vim.fn.jobstart({ utils.open_command(), debugger_tab_url }, { detach = true })
end

function M.open_provider_tab()
  -- split at before the first question mark
  local profiler_url = flutter_dev_tools.get_profiler_url()
  if profiler_url == nil then
    vim.notify("profiler_url is nil")
    return
  end
  -- split string
  local parts = splitUrl(profiler_url)
  --[[ for part in profiler_url:gmatch("[^?]+") do
    table.insert(parts, part)
  end ]]
  local url = parts[1]
  local query = parts[2]
  -- insert the string 'provider' between the url and the query
  local provider_tab_url = url .. "provider_ext?" .. query
  vim.notify("Opening provider tab: " .. provider_tab_url)
  vim.fn.jobstart({ utils.open_command(), provider_tab_url }, { detach = true })
end

return M
