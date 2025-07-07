local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('oonamo/ef-themes.nvim')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')

Plug('nvim-treesitter/nvim-treesitter')

Plug('ellisonleao/gruvbox.nvim')

Plug('preservim/nerdtree')

vim.call('plug#end')

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
  command = "!pdflatex main.tex; pkill -HUP mupdf",
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
-- vim.cmd.colorscheme("ef-dream")

--
vim.keymap.set('n', '<Leader>e', '<cmd>NERDTreeToggle<cr>')

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
