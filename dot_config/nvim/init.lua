vim.g.is_unix = vim.loop.os_uname().sysname == "Darwin"
vim.g.mapleader = " "


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local plugins = require('custom.plugins')
require("lazy").setup(plugins)

if not vim.g.is_unix then
  vim.env.PATH = 'C:\\Users\\michael.glaviano\\AppData\\Roaming\\nvm\\v19.3.0;' .. vim.env.PATH
end

local start_time


local before_init = function()
  start_time = os.time()
  vim.cmd[[colorscheme gruvbox-material]]
end

-- Package manager

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.

-- Automatically source and re-compile packer whenever you save this init.lua

-- [[ Setting options ]]
-- See `:help vim.o`

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

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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

-- Set lualine as statusline
-- See `:help lualine.txt`

-- Enable Comment.nvim

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`

-- Gitsigns
-- See `:help gitsigns.txt`

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
require("telescope").load_extension "file_browser"
-- See `:help telescope.builtin`
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


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('orgmode').setup_ts_grammar()
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'org', 'c_sharp', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'svelte', 'vim' },
  highlight = { 
    enable = true,
    additional_vim_regex_highlighting = {'org'}
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
	-- You can use the capture groups defined in textobjects.scm
	['aa'] = '@parameter.outer',
	['ia'] = '@parameter.inner',
	['af'] = '@function.outer',
	['if'] = '@function.inner',
	['ac'] = '@class.outer',
	['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
	[']m'] = '@function.outer',
	[']]'] = '@class.outer',
      },
      goto_next_end = {
	[']M'] = '@function.outer',
	[']['] = '@class.outer',
      },
      goto_previous_start = {
	['[m'] = '@function.outer',
	['[['] = '@class.outer',
      },
      goto_previous_end = {
	['[M'] = '@function.outer',
	['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
	['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
	['<leader>A'] = '@parameter.inner',
      },
    }
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local end_time = os.time()
  vim.cmd[[colorscheme gruvbox]]
  local elapsed_time = end_time - start_time

  print('lsp attached in ' .. tostring(elapsed_time) .. ' seconds')
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end


  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end

-- Setup mason so it can manage external tooling
require('mason').setup()

local servers = { 'clangd', 'pyright', 'tsserver', 'sumneko_lua', 'volar', 'svelte', 'omnisharp' }

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    before_init = before_init,
    capabilities = capabilities,
  }
end


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  before_init = before_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
	version = 'LuaJIT',
	path = runtime_path,
      },
      diagnostics = {
	globals = { 'vim' },
      },
      workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

local pid = vim.fn.getpid()
local omnisharp_bin = "C:\\Users\\michael.glaviano\\.local\\share\\nvim-data\\mason\\packages\\omnisharp\\OmniSharp.exe"
if vim.g.is_unix then
  omnisharp_bin = "/Users/mg/.local/share/nvim/mason/bin/omnisharp"
end

local root_pattern = require('lspconfig.util').root_pattern
local config = {
  -- autostart = false,
  before_init = before_init,
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = root_pattern('*.sln'),
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
	signs = {
	  severity_limit = 2
	},
	virtual_text = {
	  severity_limit = 2
	},
	underline = {
	  severity_limit = 1
	}
      }
    )
  },
  cmd = require('custom.helpers').sln_helper_omni(omnisharp_bin, pid),
}

if vim.g.is_unix then
  before_init = before_init
  on_attach = on_attach
  config = {
    root_dir = root_pattern('*.sln', '*.csproj'),
    handlers = {
      ["textDocument/definition"] = require('omnisharp_extended').handler
    },
    cmd = {omnisharp_bin, '--languageserver', '--hostPID', tostring(pid)}   
  }

end

require'lspconfig'.omnisharp.setup(config)

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
	cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
	luasnip.expand_or_jump()
      else
	fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
	cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
	luasnip.jump(-1)
      else
	fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}



local extension_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension'
local codelldb_path = extension_path .. '/adapter/codelldb'
local liblldb_path = extension_path .. '/lldb/lib/liblldb.dylib'

local rt = require("rust-tools")
local opts = {
  -- ... other configs
  server = {
    on_attach = on_attach,
    before_init = before_init
  },
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      codelldb_path, liblldb_path)
  }
}

-- Normal setup
rt.setup(opts)
