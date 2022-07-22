--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
-- vim.g.mapleader = " "
-- vim.g.localleader = "\\"

-- IMPORTS
require "user.options"      -- Options
require "user.keymaps"      -- Keymaps
require "user.plugins"       -- Plugins
require "user.colorscheme"
-- require('user.variables')      -- Variables

-- PLUGINS: Add this section
require "user.nvim-tree"
require "user.comment"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.impatient"
require "user.indentline"
require "user.alpha"
require "user.auto-session"
-- require "user.lsp-inlayhints"
require "user.hop"
