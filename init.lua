-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            use {
                'j-hui/fidget.nvim',
                tag = 'legacy',
            },

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',

            -- Prettier & Lint for LSP
            -- Can not setting prettier with mason yet -> use null-ls and self config instead
            'jose-elias-alvarez/null-ls.nvim'
        }
    }
    -- Ensure neodev.nvim and null-ls.nvim are installed explicitly
    use 'folke/neodev.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'

    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    }

    use 'github/copilot.vim' -- :Copilot status - to check copilot status
    use { -- :CopilotChat - to open chat window
      'CopilotC-Nvim/CopilotChat.nvim',
        requires = {
            'github/copilot.vim',
            'nvim-lua/plenary.nvim'
        }
    }

    use {                    -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }

    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    use { -- File Explorer
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        }
    }

    -- Git related plugins
    -- use 'tpope/vim-fugitive'
    -- use 'tpope/vim-rhubarb'
    use 'lewis6991/gitsigns.nvim'
    use 'rhysd/conflict-marker.vim'

    -- [[ Themes ]]
    use 'navarasu/onedark.nvim' -- Theme inspired by Atom
    use 'rebelot/kanagawa.nvim'
    use 'sainnhe/everforest'
    use 'catppuccin/nvim'

    use 'nvim-lualine/lualine.nvim'           -- Fancier statusline
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'numToStr/Comment.nvim'               -- "gc" to comment visual regions/lines
    use 'tpope/vim-sleuth'                    -- Detect tabstop and shiftwidth automatically
    use 'jiangmiao/auto-pairs'                -- Auto pairs brackets, parens, quotes, etc.

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }


    -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
    local has_plugins, plugins = pcall(require, 'custom.plugins')
    if has_plugins then
        plugins(use)
    end

    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})

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
-- Set themes
vim.o.termguicolors = true
-- vim.cmd [[colorscheme everforest]]
vim.cmd [[colorscheme kanagawa]]
-- vim.cmd [[colorscheme catppuccin]]
-- Set the behavior of tab
vim.opt.tabstop = 4     -- insert 4 spaces for a tab
vim.opt.expandtab = true
vim.opt.shiftwidth = 4  -- the number of spaces inserted for each indentation
vim.opt.softtabstop = 4 -- number of spaces to use for each step of (auto)indent
vim.opt.scrolloff = 8
-- [[ Use tab on visual mode ]]
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
-- Setup split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Setup conflict_maker
vim.g.conflict_marker_highlight_group = 'Error';
-- Default values
vim.g.conflict_marker_begin = '^<<<<<<< \\@=';
vim.g.conflict_marker_common_ancestors = '^||||||| .*$';
vim.g.conflict_marker_separator = '^=======$';
vim.g.conflict_marker_end   = '^>>>>>>> \\@=';

-- [[ Copilot setup tab behavior ]]
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

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
-- Hanle for yank to clipboard
vim.opt.clipboard = 'unnamedplus'
-- Remap exit insert mode to jk
vim.keymap.set('i', 'jk', "<ESC>", { noremap = true, silent = true })
-- Remap others
vim.keymap.set('n', '<c-w>', ":bd<CR>", { noremap = true, silent = true, desc = 'Delete current buffer' })
vim.keymap.set('n', 'o', "o<Esc>", { noremap = true, silent = true, desc = 'Append new line below' })
vim.keymap.set('n', 'O', "O<Esc>", { noremap = true, silent = true, desc = 'Append new line above' })
vim.keymap.set('n', '<c-h>', "<c-w>h", { noremap = true, silent = true, desc = 'Switch to Left Window' })
vim.keymap.set('n', '<c-l>', "<c-w>l", { noremap = true, silent = true, desc = 'Switch to Right Window' })
vim.keymap.set('n', '<c-j>', "<c-w>j", { noremap = true, silent = true, desc = 'Switch to Below Window' })
vim.keymap.set('n', '<c-k>', "<c-w>k", { noremap = true, silent = true, desc = 'Switch to Above Window' })

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

--
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some option
local function nvim_tree_on_attach(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
        return { desc = '[File Explorer] ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.set('n', '<c-s>', api.node.open.vertical, opts('Open vertical split'))
    vim.keymap.set('n', '<c-h>', api.node.open.horizontal, opts('Open horizontal split'))
    vim.keymap.set('n', '<c-n>', api.fs.create, opts('Create node'))
    vim.keymap.set('n', '<c-d>', api.fs.remove, opts('Delete node'))
    vim.keymap.set('n', '<c-r>', api.fs.rename, opts('Rename node'))
    vim.keymap.set('n', '<c-x>', api.fs.cut, opts('Cut node'))
    vim.keymap.set('n', '<c-c>', api.fs.copy.node, opts('Copy node'))
    vim.keymap.set('n', '<c-v>', api.fs.paste, opts('Paste node'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
end
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    on_attach = nvim_tree_on_attach,
    view = {
        adaptive_size = true
        -- hide_root_folder = false,
    },
    renderer = {
        group_empty = true,
    },
    -- filters = {
    --     dotfiles = true,
    -- },
})
local function open_nvim_tree(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
        return
    end
    -- create a new, empty buffer
    vim.cmd.enew()
    -- wipe the directory buffer
    vim.cmd.bw(data.buf)
    -- change to the directory
    vim.cmd.cd(data.file)
    -- open the tree
    require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

vim.keymap.set('n', '<c-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<c-t>', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })


require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest,
  window = {
    layout = "float",
    width = 0.7,
    height = 0.7,
    border = "solid",
    highlight = "Normal",
  },
}

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'kanagawa',
        component_separators = '|',
        section_separators = '',
    },
}

-- Enable Comment.nvim
require('Comment').setup({
    toggler = {
        line = '<leader>c<space>'
    },
    opleader = {
        line = '<leader>c<space>'
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
})
-- vim.keymap.set('n', '<leader>?', require('Comment.config').set, { desc = '[?] Find recently opened files' })

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
-- require('indent_blankline').setup {
--     char = '┊',
--     show_trailing_blankline_indent = false,
-- }
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup {
    scope = { highlight = highlight },
    indent = { char = '┊' },
    whitespace = {
        remove_blankline_trail = false,
    }
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
    defaults = {
        path_display = { "smart" }, -- Display with .../<parent_node>/<searched_name_file>
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = require('telescope.actions').delete_buffer,
                ["<C-s>"] = require('telescope.actions').select_vertical,
                ["<C-h>"] = require('telescope.actions').select_horizontal,
            },
        },
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            file_display = 10
        },
        live_grep = {
            theme = "dropdown",
        },
        buffers = {
            theme = "dropdown",
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').keymaps, { desc = '[?] Lists normal mode keymappings' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sc', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = 'Fuzzily [S]earch in [C]urrent buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sa', require('telescope.builtin').live_grep, { desc = '[S]earch by [A]ll Files' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
    { desc = '[S]earch current [W]ord In Workspace' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'Telescope Git Status' })
vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = 'Telescope Git Branch' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = 'Telescope Git Commits' })
vim.keymap.set('n', '<leader>gC', require('telescope.builtin').git_bcommits, { desc = 'Telescope Git BCommits' })
-- vim.keymap.set('n', '<leader>gr', require('telescope.builtin').git_bcommits_range, { desc = 'Telescope Git BCommits' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'javascript', 'help' },

    highlight = { enable = true },
    indent = { enable = true, disable = { 'python' } },
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
        },
    },
}

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Move [D]iagnostics [P]revious', silent = true })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Open [D]iagnostics [N]ext', silent = true })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open [D]iagnostics [F]loat', silent = true })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics [L]ist', silent = true })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
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
    local vmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('cd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('cr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('ci', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    vmap('<space>f', function() vim.lsp.buf.format { async = true } end, '[F]ormat in visual')
    nmap('<space>f', function() vim.lsp.buf.format { async = true } end, '[F]ormat in normal')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    -- completion keymaps
    -- vim.keymap.set('i', '<c-space>', vim.lsp.buf.completion, { buffer = bufnr, desc = 'Trigger completion' })

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}

-- Turn on lsp status information
require('fidget').setup()

-- Turn on lsp prettier & lint
require('null-ls').setup({
    debug = false,
    sources = {
        require('null-ls').builtins.formatting.prettier
    }
})

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    completion = {
        autocomplete = { 'TextChanged' } -- Auto display completion menu
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        -- ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
