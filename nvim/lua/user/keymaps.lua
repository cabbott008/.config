--[[ keymaps.lua ]]
M = {}
local opts = { noremap = true, silent = true} -- allows me to shorten code through substitution

local keymap = vim.api.nvim_set_keymap

-- Remap space as the leader key
keymap("", " ", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)
-- keymap("n", "<C-i>", "<C-i>", opts)

-- remap the key used to leave insert mode
-- mode: the mode you want the key bind to apply to (e.g., insert mode, normal mode, command mode, visual mode).
    --   normal_mode = "n",
    --   insert_mode = "i",
    --   visual_mode = "v",
    --   visual_block_mode = "x",
    --   term_mode = "t",
    --   command_mode = "c",
-- sequence: the sequence of keys to press.
-- command: the command you want the keypresses to execute.
-- options: an optional Lua table of options to configure (e.g., silent or noremap). Replaced by opts

-- Normal --
-- Better window navigation
-- keymap("n", "<m-s>", "<C-w>h", opts)
-- keymap("n", "<m-e>", "<C-w>j", opts)
-- keymap("n", "<m-n>", "<C-w>k", opts)
-- keymap("n", "<m-i>", "<C-w>l", opts)

-- Tabs --
-- keymap("n", "<enter>", ":tabnew %<cr>", opts)
-- keymap("n", "<s-enter>", ":tabclose<cr>", opts)
-- keymap("n", "<m-\\>", ":tabonly<cr>", opt)

-- Yank all
keymap("n", "<leader>y", ":%y<cr>", opts)

-- Navigate buffers
keymap('n', "<leader>i", ":bnext<CR>", opts)
keymap('n', "<leader>s", ":bprevious<CR>", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- MoonLander
-- Have n and e replace j and k to navigate logical lines and Caps visible ones
keymap("", "N", "gk", opts)
keymap("", "E", "gj", opts)
keymap("", "n", "k", opts)
keymap("", "e", "j", opts)
keymap("", "zn", "zt", opts)
keymap("", "ze", "zb", opts)

-- Have s and i handle left and right instead of h and l
keymap("", "s", "h", opts)
keymap("", "i", "l", opts)

-- Have - and _ handle backward navigation to beginning of words for b and B
keymap("", "-", "b", opts)
keymap("", "_", "B", opts)

-- Have b and B handle navigation to end of words for e and E
keymap("", "b", "e", opts)
keymap("", "B", "E", opts)

-- Have L and l handle inserting for I and i
keymap("", "L", "I", opts)
keymap("", "l", "i", opts)
keymap("", "gl", "gi", opts)

-- Have h and H handle the functions of J (and give J a job)
keymap("n", "h", "J", opts)
keymap("n", "H", "gJ", opts)
keymap("n", "J", "<C-r>", opts)

-- Have k and j handle search navigation for N and n 
keymap("", "k", "N", opts)
keymap("", "j", "n", opts)

-- Repairing the strangeness
keymap("", "<Left>", "h", opts)
keymap("", "<Right>", "l", opts)
keymap("", "<Down>", "j", opts)
keymap("", "<Up>", "k", opts)

-- Have S and I handle moving to the top/bottom of the screen for H and L
keymap("", "S", "H", opts)
keymap("", "I", "L", opts)

-- Have g- and g_ handle reverse end of word travel
keymap("", "g-", "ge", opts)
keymap("", "g_", "gE", opts)

-- noremap x "_x
-- noremap X "_X
keymap("n", "<BS>", "X", opts)

-- For command mode
keymap("c", "<S-Tab>", "<<", opts)
-- For insert mode
keymap("i", "<S-Tab>", "<C-d>", opts)

-- Toggle nvim-tree
keymap('n', '<leader>n', ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap('n', '<leader>ff', ":Telescope find_files<CR>", opts)
keymap('n', '<leader>ft', ":Telescope live_grep<CR>", opts)
keymap('n', '<leader>fp', ":Telescope projects<CR>", opts)
keymap('n', '<leader>fb', ":Telescope buffers<CR>", opts)

-- Hop
keymap('', '<leader>f', "<cmd>lua require'hop'.hint_char2()<CR>", opts)
keymap('', '<leader>w', "<cmd>lua require'hop'.hint_words()<CR>", opts)
keymap('', '<leader>l', "<cmd>lua require'hop'.hint_lines()<CR>", opts)
keymap('', '<leader>L', "<cmd>lua require'hop'.hint_vertical()<CR>", opts)
keymap('', '<leader>p', "<cmd>lua require'hop'.hint_patterns()<CR>", opts)

vim.keymap.set('n', '<leader>o', function()
  vim.cmd(':HopLineStart')
  vim.schedule(function()
    vim.cmd(':normal o')
    vim.cmd(':normal o')
    vim.cmd('startinsert')
    end)
end, opts)

vim.keymap.set('n', '<leader>O', function()
  vim.cmd(':HopLineStart')
  vim.schedule(function()
    vim.cmd(':normal O')
    vim.cmd(':normal O')
    vim.cmd('startinsert')
    end)
end, opts)

-- LSP
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
keymap("n", "<leader>lF", "<cmd>LspToggleAutoFormat<CR>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<CR>", opts)
keymap("n", "<leader>lI", "<cmd>LspInstallInfo<CR>", opts)
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<CR>", opts)
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

-- ToggelTerm
-- keymap("", "<leader>x", ":ToggleTermToggleAll<CR>", opts)

-- Git
keymap("", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

return M
