local k = vim.keymap.set
k("n", "<leader>bc", ":bd<CR>")
k("n", "<leader>w", ":w<CR>")
k("n", "<leader>5", ":source %<CR>")
k("n", "<Tab>", ":bnext<CR>")
k("n", "<S-Tab>", ":bprevious<CR>")
k("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")
k("n", "<M-w>", ":split<CR>")
k("n", "<M-v>", ":vsplit<CR>")
k("n", "<C-q>", ":quit<CR>")
k("n", "<leader>ft", vim.lsp.buf.format, { desc = "Format file" })

local function move_lines(direction)
	local count = vim.v.count1
	local mode = vim.fn.mode(1)
	local lnum = vim.fn.line(".")
	local last = vim.fn.line("$")

	if mode:match("^V") or mode:match("^") then
		local start = vim.fn.line("'<")
		local finish = vim.fn.line("'>")
		if direction == ">" and finish + count >= last then
			vim.notify("Ya al final del archivo", vim.log.levels.WARN)
			return
		elseif direction == "<" and start - count <= 1 then
			vim.notify("Ya al inicio del archivo", vim.log.levels.WARN)
			return
		end
		local target = (direction == ">") and ("'>+" .. (count - 1)) or ("'<-" .. (count + 1))
		vim.cmd(":'<,'>move " .. target)
		vim.cmd("normal! gv")
	else
		if direction == ">" and lnum + count >= last then
			vim.notify("Ya al final del archivo", vim.log.levels.WARN)
			return
		elseif direction == "<" and lnum - count <= 1 then
			vim.notify("Ya al inicio del archivo", vim.log.levels.WARN)
			return
		end
		local target = (direction == ">") and ("+" .. count) or ("-" .. (count + 1))
		vim.cmd(".move " .. target)
		vim.cmd("normal! ==")
		if mode == "i" then
			vim.cmd("startinsert")
		end
	end
end
vim.keymap.set({ "n", "i", "v" }, "<A-j>", function()
	move_lines(">")
end, { desc = "Move down" })
vim.keymap.set({ "n", "i", "v" }, "<A-k>", function()
	move_lines("<")
end, { desc = "Move up" })
