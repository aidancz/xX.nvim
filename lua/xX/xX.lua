-- fix x and X key when "virtualedit=all"
-- fuck the fucking chaos index of row and col
-- fuck lua for 1-based index

xX = {}

xX.fun = function(direction)
	xX.direction = direction
	vim.go.operatorfunc = "v:lua.xX.fun_callback"
	return "g@l"
end

xX.fun_callback = function()
	-- local pos1 = vim.api.nvim_win_get_cursor(0)
	-- local row1 = pos1[1]
	-- local col1 = pos1[2]

	local pos1 = vim.fn.getcharpos(".")
	local row1 = pos1[2]
	local col1 = pos1[3]
	local col1_byte = vim.fn.col(".")

	if xX.direction then
		vim.fn.setcursorcharpos(row1, col1 + vim.v.count1)
	else
		vim.fn.setcursorcharpos(row1, col1 - vim.v.count1)
	end

	local pos2 = vim.fn.getcharpos(".")
	local row2 = pos2[2]
	local col2 = pos2[3]
	local col2_byte = vim.fn.col(".")

	local row_beg
	local row_end
	if row1 <= row2 then
		row_beg = row1
		row_end = row2
	else
		row_beg = row2
		row_end = row1
	end

	local col_byte_beg
	local col_byte_end
	if col1_byte <= col2_byte then
		col_byte_beg = col1_byte
		col_byte_end = col2_byte
	else
		col_byte_beg = col2_byte
		col_byte_end = col1_byte
	end

	local text = vim.api.nvim_buf_get_text(0, row_beg - 1, col_byte_beg - 1, row_end - 1, col_byte_end - 1, {})
	-- print(vim.inspect(text))
	vim.fn.setreg("",  text, "c")
	vim.fn.setreg("-", text, "c")
	vim.fn.setreg("*", text, "c")
	vim.fn.setreg("+", text, "c")

	vim.api.nvim_buf_set_text(0, row_beg - 1, col_byte_beg - 1, row_end - 1, col_byte_end - 1, {})
end
