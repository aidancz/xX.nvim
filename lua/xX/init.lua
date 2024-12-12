require("xX/xX")

vim.keymap.set("n", "x", function() return xX.fun(true)  end, {expr = true})
vim.keymap.set("n", "X", function() return xX.fun(false) end, {expr = true})
