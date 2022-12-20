-- hop 
local hop = require('hop')
vim.keymap.set('n', 's', function()
	hop.hint_char1({ direction = nil })
end, {remap=true})

-- ergonomics
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'kj', '<esc>')

-- overwin motion
vim.keymap.set('n', '<leader>h', '<C-W>h')
vim.keymap.set('n', '<leader>j', '<C-W>j')
vim.keymap.set('n', '<leader>k', '<C-W>k')
vim.keymap.set('n', '<leader>l', '<C-W>l')

-- telescope kickstart overrides
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
_G.project_files = function()
	local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' }) 
	if ret == 0 then 
		builtin.git_files() 
	else
		builtin.find_files()
	end 
end 
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.api.nvim_set_keymap('n', ',', '<cmd>lua project_files()<CR>', {noremap=true})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind with live [g]rep' })

-- bufferline
local bufferline = require('bufferline')
vim.keymap.set('n', '<leader>bp', bufferline.pick_buffer)
vim.keymap.set('n', '<leader>bk', bufferline.close_buffer_with_pick)

-- workaround while NvimTreeToggle is broken
-- _G.toggle_nvimtree = function()
-- 	local win_list = vim.api.nvim_list_wins()
-- 	if win_list[1] ~= 1000 then
-- 		local first_win_buf_num = vim.api.nvim_win_get_buf(win_list[1])
-- 		local first_win_buf_name = vim.api.nvim_buf_get_name(first_win_buf_num)
-- 		local is_nvimtree = string.find(first_win_buf_name, "NvimTree_1")
-- 		if is_nvimtree ~= nil then
-- 			vim.api.nvim_win_close(win_list[1], true)
-- 		else
-- 			vim.api.nvim_command("NvimTreeFindFileToggle")
-- 		end
-- 	else
-- 		vim.api.nvim_command("NvimTreeFindFileToggle")
-- 	end
-- end
-- vim.keymap.set('n', '<leader>tt', toggle_nvimtree)
--
vim.keymap.set('n', '<leader>tt', '<cmd>CHADopen<cr>')
vim.g.chadtree_settings = {
	theme = {
	text_colour_set = 'solarized_dark'
	}
}



-- setopts
vim.opt.exrc = true
vim.opt.nu = true 
vim.opt.hlsearch = false
vim.opt.hidden = true 
vim.opt.errorbells = false
vim.opt.tabstop = 2
vim.opt.softtabstop = -1
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
if vim.g.is_unix then
vim.opt.undodir = '~/.nvim/undodir'
else 
vim.opt.undodir = vim.env.XDG_DATA_HOME .. '.nvim\\undodir'
end 
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.splitright = true

-- theme
vim.g.colors_name = 'gruvbox'
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'soft'
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Comment.nvim

local comment = require('Comment.api')
local esc = vim.api.nvim_replace_termcodes(
	'<ESC>', true, false, true
)
vim.keymap.set('n', '<leader>ci', comment.toggle.linewise.current)
vim.keymap.set('x', '<leader>ci', function()
	vim.api.nvim_feedkeys(esc, 'nx', false)
	comment.toggle.linewise(vim.fn.visualmode())
end)

-- Diffview
--

vim.keymap.set('n', '<leader>dvo', '<cmd>DiffviewOpen<cr>')
vim.keymap.set('n', '<leader>dvc', '<cmd>DiffviewClose<cr>')
vim.keymap.set('n', '<leader>dvb', function()
	vim.ui.input({
		prompt = "diff against branch: ",
		}, function(input)
			return vim.api.nvim_command('DiffviewOpen ' .. input)
		end
	)

end
)

-- undotree 
vim.keymap.set('n', '<leader>tu', '<cmd>UndotreeToggle<CR>')
