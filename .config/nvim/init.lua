local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('oonamo/ef-themes.nvim')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')

Plug('nvim-treesitter/nvim-treesitter')

Plug('ellisonleao/gruvbox.nvim')

Plug('preservim/nerdtree')

Plug 'mfussenegger/nvim-jdtls'

Plug 'mfussenegger/nvim-jdtls'

Plug 'mason-org/mason.nvim'

Plug 'mason-org/mason-lspconfig.nvim'

Plug 'rebelot/kanagawa.nvim'


Plug 'hrsh7th/vim-vsnip'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

vim.call('plug#end')

require("mason").setup()
require("mason-lspconfig").setup()

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.cursorline = true

vim.g.mapleader = " "

vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = {"*.tex"},
	-- command = "!pdflatex main.tex; pkill -HUP mupdf",
  command = "!pdflatex document.tex; pkill -HUP mupdf",
})

vim.o.background = "dark"
-- vim.cmd([[colorscheme gruvbox]])
-- vim.cmd.colorscheme("ef-dream")
vim.cmd.colorscheme("kanagawa-dragon")
-- vim.cmd.colorscheme("doom-miramare")

--
vim.keymap.set('n', '<Leader>e', '<cmd>NERDTreeToggle<cr>')

-- vim.keymap.set('n', 'ZZ', '<Nop>')
-- vim.keymap.set('n', 'ZQ', '<Nop>')

--
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader><Leader>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<Leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<Leader>bb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<Leader>bk', ':bd')

--
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}







-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

      -- For `mini.snippets` users:
      -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      -- insert({ body = args.body }) -- Insert at cursor
      -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      -- require("cmp.config").set_onetime({ sources = {} })
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
)
equire("cmp_git").setup() ]]--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace jdtls with each lsp server you've enabled.
vim.lsp.config('jdtls', {
  capabilities = capabilities
})
vim.lsp.enable('jdtls')
