" Disable supertab if blink.cmp is installed and coc.nvim is not
" Load both this and blink.cmp from ~/.config/nvim and then load the supertab
" from ~/.vim -> this will load first.

lua << EOF
local ok, _ = pcall(require, 'blink.cmp')
if ok and not vim.g.did_coc_loaded then
  vim.g.loaded_supertab = 1
end
EOF
