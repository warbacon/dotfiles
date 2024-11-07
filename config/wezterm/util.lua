local wezterm = require("wezterm")

---@class WeztermUtils
local M = {}

---@type boolean
M.is_win = wezterm.target_triple:find("windows") ~= nil

---@type string
M.hostname = wezterm.hostname()

---@param command string
---@return boolean
function M.command_exists(command)
	if M.is_win then
		return wezterm.run_child_process({ "where", command }) and true
	else
		return wezterm.run_child_process({ "which", command }) and true
	end
end

return M
