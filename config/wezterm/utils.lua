local wezterm = require("wezterm")

local M = {}

M.is_win = wezterm.target_triple:find("windows") ~= nil
M.hostname = wezterm.hostname()

function M.command_exists(command)
	if M.is_win then
		return wezterm.run_child_process({ "where", command })
	else
		return wezterm.run_child_process({ "which", command })
	end
end

return M
