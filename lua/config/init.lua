require("config.options")
require("config.keymaps")


local g = vim.g
local o = vim.opt
local c = vim.cmd
local k = vim.keymap
g.mapleader = " "

o.relativenumber = true
o.number = true

k.set("n","<leader>0" , ":bfirst<CR>")
k.set("n","<leader>1" , ":blast<CR>")
k.set("n","<leader>w", ":w<CR>")
k.set("n","<leader>s", ":so %<CR>")
k.set("n", "<Tab>", ":bnext<CR>")
k.set("n","<S-Tab>",":brevious<CR>")


