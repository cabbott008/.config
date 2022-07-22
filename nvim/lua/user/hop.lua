local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end
require'hop'.setup {
  keys = 'adenishrucolgypmfbwvkxjqz',
  hint_position = require'hop.hint'.HintPosition.BEGIN,
  char2_fallback_key = "<CR>",
  uppercase_labels = true,
  multi_windows = false,
  hint_offset = 0,
  smartcase = false,
  teasing = false
}

-- local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap
