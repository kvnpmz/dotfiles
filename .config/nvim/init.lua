vim.opt.shortmess:append("I")

vim.cmd("filetype indent off")

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove({ "o", "r" })
    end
})

vim.filetype.add({
    extension = { tl = "teal" }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "teal",
    callback = function()
        vim.bo.indentexpr = "GetLuaIndent()"
    end,
})

for name in pairs(vim.api.nvim_get_hl(0, {})) do
    vim.api.nvim_set_hl(0, name, {})
end

local dark, orange = "#231F1D", "#FFA500"
local inverted = { "Visual", "StatusLineNC", "Folded" }

for _, name in ipairs(inverted) do
    vim.api.nvim_set_hl(0, name, { fg = dark, bg = orange })
end

local options = {
    clipboard = "unnamedplus", guicursor = "i:block",
    tabstop = 4, shiftwidth = 4, expandtab = true,
    autoindent = false, termguicolors = true
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd([[ 
call plug#begin('~/.vim/plugged')
call plug#end() 
]])

