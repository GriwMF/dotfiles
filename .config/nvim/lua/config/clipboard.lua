local function is_wsl()
	local handle = io.popen("uname -r 2>/dev/null")
	if handle then
		local result = handle:read("*a")
		handle:close()

		if result then
			result = result:lower()
			if result:match("microsoft") or result:match("wsl") then
				return true
			end
		end
	end
	return false
end

if is_wsl() then
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			["+"] = 'clip.exe',
			["*"] = 'clip.exe',
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
else
	vim.g.clipboard = {
		name = 'WaylandClipboard',
		copy = {
			["+"] = 'wl-copy',
			["*"] = 'wl-copy',
		},
		paste = {
			["+"] = 'wl-paste --no-newline',
			["*"] = 'wl-paste --no-newline',
		},
		cache_enabled = 0,
	}
end

