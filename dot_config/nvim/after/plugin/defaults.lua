
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', function()
  return require('telescope.builtin').diagnostics({severity_limit = 2})

end
  , { desc = '[S]earch [D]iagnostics' })

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

vim.api.nvim_set_keymap(
	'n',
	'<space>tk',
	':Telescope keymaps<cr>',
	{ noremap = true }
)
-- tree 
vim.api.nvim_set_keymap(
	'n',
	'<space>tt',
	':Telescope file_browser<cr>',
	{ noremap = true }
)
-- bufferline
local bufferline = require('bufferline')
vim.keymap.set('n', '<leader>bp', bufferline.pick_buffer)
vim.keymap.set('n', '<leader>bk', bufferline.close_buffer_with_pick)

-- hop 
local hop = require('hop')
vim.keymap.set('', 's', function()
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
if vim.g.is_osx then
	vim.opt.undodir = vim.env.HOME .. '/.nvim/undodir'
else
	vim.opt.undodir = vim.env.XDG_DATA_HOME .. '.nvim\\undodir'
	-- fun
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
vim.opt.fixeol = false

vim.o.background = 'dark' -- or 'light' for light mode
vim.o.cmdheight = 0

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
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
		prompt = 'diff against branch: ',
		}, function(input)
			return vim.api.nvim_command('DiffviewOpen ' .. input)
		end
	)

end
)

-- undotree 
vim.keymap.set('n', '<leader>tu', '<cmd>UndotreeToggle<CR>')

-- debug

local dap = require('dap')
dap.adapters.coreclr = {
	type = 'executable',
	-- command = [[C:\Users\michael.glaviano\.local\share\nvim-data\mason\packages\netcoredbg\netcoredbg\netcoredbg.exe]],
	command = [[C:\Users\michael.glaviano\netcoredbg\netcoredbg.exe]],
	args = {'--interpreter=vscode'}
}
-- dap.adapters.codelldb = {
--   type = 'server',
--   host = '127.0.0.1',
--   port = 13000
-- }
dap.configurations.cs = {
	{
		type = 'coreclr',
		name = 'attach - netcoredbg',
		request = 'attach',
		processId = '${command:pickProcess}',
	}
}
local dapui =  require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function()
	dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
	dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
	dapui.close()
end
require('dapui').setup()


local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
	for _, buf in pairs(api.nvim_list_bufs()) do
		local keymaps = api.nvim_buf_get_keymap(buf, 'n')
		for _, keymap in pairs(keymaps) do
			if keymap.lhs == 'K' then
				table.insert(keymap_restore, keymap)
				api.nvim_buf_del_keymap(buf, 'n', 'K')
			end
		end
	end
	api.nvim_set_keymap(
		'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
	for _, keymap in pairs(keymap_restore) do
		api.nvim_buf_set_keymap(
			keymap.buffer,
			keymap.mode,
			keymap.lhs,
			keymap.rhs,
			{ silent = keymap.silent == 1 }
		)
	end
	keymap_restore = {}
end

vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dso', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>dsi', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>rd', '<cmd>RustDebuggables<cr>1<cr>')


-- trouble
-- maybe kill this now that lsplines works
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>',
	{silent = true, noremap = true}
)
vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>',
	{silent = true, noremap = true}
)
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
	{silent = true, noremap = true}
)
vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>',
	{silent = true, noremap = true}
)
vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',
	{silent = true, noremap = true}
)
vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>',
	{silent = true, noremap = true}
)

vim.diagnostic.config({
	virtual_text = false,
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
