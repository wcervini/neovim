local M = {}

function M.opts(desc)
	return {
		desc = desc,
		noremap = true,
		silent = false,
	}
end
M.get_pnpm_tsdk = function()
  -- Get the pnpm global root (e.g., ...\pnpm\global\5\node_modules)
  local handle = io.popen("pnpm root -g")
  local pnpm_root = handle:read("*a"):gsub("%s+$", "")
  handle:close()

  if pnpm_root ~= "" then
    -- Convert Windows \ to / for Neovim compatibility and add the subpath
    local path = pnpm_root .. "/typescript/lib"
    return path:gsub("\\", "/")
  end
  return nil
end
return M
