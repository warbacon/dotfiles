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

function M.tableMerge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				M.tableMerge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end

return M
