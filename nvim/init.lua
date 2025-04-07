-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.opt.guicursor = ""                -- turn off skinny gui cursor
vim.opt.mouse = ""                    -- no mouse support

vim.opt.scrolloff = 5                 -- Keep 5 lines above/below when scrolling
vim.opt.number = true                 -- Show numbers
vim.opt.cursorline = true             -- Highlight the cursor line
vim.opt.colorcolumn = "80"            -- Color the 80th column

-- Formatting options
vim.opt.autoindent = true             -- automatically indent
vim.opt.wrap = false                  -- wrap long lines 
vim.opt.expandtab = true              -- use spaces not TABs
vim.opt.shiftwidth = 3                -- 3 spaces per indent
vim.opt.tabstop = 3                   -- indent every 3 columns
vim.opt.softtabstop = 3               -- let backspace delete indents
vim.opt.smarttab = true               -- Let TAB/BSpace insert/delete spaces 

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "vim-scripts/xoria256.vim",
      lazy = false,
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        vim.cmd([[colorscheme xoria256]])
      end,
    },
    { "myusuf3/numbers.vim",
      config = function()
      end,
    },
    { "easymotion/vim-easymotion",
      config = function()
      end,
    },
    { "vim-airline/vim-airline",
      dependencies = {
        "vim-airline/vim-airline-themes",
      },
      init = function()
	     vim.g.airline_extensions_whitespace_enabled = 0 -- Disable whitespace warnings
	     vim.g.airline_extensions_tagbar_enabled = 0     -- Disable tagbar integration
	     vim.g.airline_section_y = ""                    -- Don't want encoding info
        vim.g.airline_theme = "base16"                  -- Theme selection
      end,
    },
    { "bling/vim-bufferline",
      dependencies = {
        "vim-airline/vim-airline",
      },
      init = function()
        vim.g.bufferline_echo = 0         -- Don't echo buffer name to command bar
        vim.g.bufferline_rotate = 1       -- Rotate buffers
        vim.g.bufferline_fixed_index = -1 -- Fix current buffer to last position
      end,
    },
    { "scrooloose/nerdtree",
       keys = {
         { "<leader>nt", "<cmd>NERDTreeToggle<cr>", desc = "NERDTree" },
       },
      init = function()
        vim.g.NERDTreeQuitOnOpen = 1       -- quit when opening stuff
        vim.g.NERDTreeKeepTreeInNewTab = 1 -- keep tree in a new tab
        vim.g.NERDTreeShowHidden = 1       -- show hidden files
        vim.g.NERDTreeIgnore = { '\\~$', '\\.swp$', '\\.git' }
        vim.g.NERDTreeWinSize = 60 -- Larger window size
      end,
    },
    { "ctrlpvim/ctrlp.vim",
       keys = {
         { "<leader>p", "<cmd>CtrlPBuffer<cr>", desc = "CtrlP" },
         { "<leader>o", "<cmd>CtrlP<cr>", desc = "CtrlP" },
       },
      init = function()
        vim.g.ctrlp_max_files = 0          -- no limit on max files
        vim.g.ctrlp_max_depth = 40         -- large projects hit the depth limit
        vim.g.ctrlp_lazy_update = 1        -- slow to search on every key press
        vim.g.ctrlp_by_filename = 1        -- only search file names
      end,
    },
    { "junegunn/fzf",
       keys = {
         { "<leader>f", "<cmd>FZF<cr>", desc = "FZF" },
       },
      config = function()
      end,
    },
    { "rking/ag.vim",
       keys = {
         { "<leader>a", "<cmd>Ag<cr>", desc = "Silver searcher" },
       },
      config = function()
      end,
    },
    { "majutsushi/tagbar",
       keys = {
         { "<leader>t", "<cmd>TagbarToggle<cr>", desc = "Tagbar" },
       },
      init = function()
        vim.g.tagbar_autoclose = 1         -- close when tag is selected
        vim.g.tagbar_autofocus = 1         -- focus when tagbar is opened
        vim.g.tagbar_width = 60            -- larger tagbar
      end,
    },
    { "rhysd/vim-clang-format",
      init = function()
        vim.g.clang_format_detect_style_file = 1  -- detect .clang-format files
      end,
    },
    { "augmentcode/augment.vim",
       keys = {
         { "<leader>ac", "<cmd>Augment chat<cr>", desc = "Augment Chat" },
         { "<leader>an", "<cmd>Augment chat-new<cr>", desc = "Augment New Chat" },
         { "<leader>at", "<cmd>Augment chat-toggle<cr>", desc = "Augment Chat Toggle" },
       },
      config = function()
      end,
    },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    -- Buffer-local normal mode mapping: <Leader>cf triggers :ClangFormat
    vim.api.nvim_buf_set_keymap(0, "n", "<Leader>cf", ":<C-u>ClangFormat<CR>",
                                { noremap = true, silent = true })
    -- Buffer-local visual mode mapping: <Leader>cf triggers :ClangFormat
    vim.api.nvim_buf_set_keymap(0, "v", "<Leader>cf", ":ClangFormat<CR>",
                                { noremap = true, silent = true })
    -- Enable auto-formatting on save
    vim.cmd("ClangFormatAutoEnable")
  end,
})

-- Colorscheme tweaks
vim.cmd([[highlight String ctermfg=229 guifg=#ffffaf]])
vim.cmd([[highlight ColorColumn ctermbg=238 guibg=#444444]])
vim.cmd([[highlight Type cterm=bold gui=bold]])
vim.cmd([[highlight Function cterm=bold gui=bold]])
vim.cmd([[highlight Conditional cterm=bold gui=bold]])
vim.cmd([[highlight Statement cterm=bold gui=bold]])
vim.cmd([[highlight Include cterm=bold gui=bold]])
vim.cmd([[highlight Boolean cterm=bold gui=bold]])
vim.cmd([[highlight Identifier cterm=bold gui=bold]])
vim.cmd([[highlight Macro cterm=bold gui=bold]])
vim.cmd([[highlight PreProc cterm=bold gui=bold]])

-- Easy window movements with CTRL+hjkl
vim.keymap.set('n', '<C-J>', '<C-W>j', { silent = true })
vim.keymap.set('n', '<C-K>', '<C-W>k', { silent = true })
vim.keymap.set('n', '<C-L>', '<C-W>l', { silent = true })
vim.keymap.set('n', '<C-H>', '<C-W>h', { silent = true })

