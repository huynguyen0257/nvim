# Neovim Configuration Handover Documentation

## 📋 Overview
This document provides comprehensive information about the Neovim configuration setup, including architecture, plugins, keybindings, and maintenance procedures.

**Date**: 2025-09-30  
**Maintainer**: Tommy  
**Neovim Version**: Compatible with 0.9+  
**Configuration Type**: Lua-based with Lazy.nvim plugin manager

---

## 🏗️ Configuration Architecture

### Directory Structure
```
~/.config/nvim/
├── init.lua                 # Main configuration entry point (548 lines)
├── lazy-lock.json          # Plugin version lockfile (~114 plugins)
├── lua/
│   ├── core/
│   │   ├── keymaps.lua     # Key mappings configuration
│   │   └── options.lua     # Neovim options and settings
│   └── plugins/
│       ├── init.lua        # Plugin declarations and setup
│       ├── autocomplete.lua # Completion-related configuration
│       └── sessions.lua    # Session management
└── README.md               # Original project documentation
```

### Configuration Philosophy
- **Modular Design**: Separated core settings from plugin configurations
- **Lazy Loading**: Uses lazy.nvim for optimized plugin loading
- **LSP-Centric**: Heavy focus on Language Server Protocol integration
- **Development-Focused**: Optimized for TypeScript, JavaScript, Python, Lua, Go

---

## 🎨 Theme and UI Configuration

### Active Theme
- **Current**: `kanagawa` (active)
- **Available**: everforest, catppuccin, moonfly, onedark

### UI Components
- **Statusline**: lualine.nvim with kanagawa theme
- **File Explorer**: nvim-tree.lua
- **Fuzzy Finder**: telescope.nvim with dropdown theme
- **Indent Guides**: indent-blankline.nvim with rainbow colors
- **Git Integration**: gitsigns.nvim

### Key UI Settings
```lua
vim.o.termguicolors = true           -- True color support
vim.o.completeopt = 'menuone,noselect' -- Better completion experience
```

---

## 🔌 Plugin Ecosystem

### Plugin Manager
- **Manager**: lazy.nvim
- **Total Plugins**: ~114 (managed in lazy-lock.json)
- **Installation**: Automatic bootstrap on first run

### Core Plugin Categories

#### 1. LSP & Language Support
```lua
- neovim/nvim-lspconfig          # LSP client configuration
- williamboman/mason.nvim        # LSP server installer
- williamboman/mason-lspconfig.nvim # Bridge between Mason and lspconfig
- WhoIsSethDaniel/mason-tool-installer.nvim # Auto-install tools
- folke/neodev.nvim             # Better Lua development
- nvimtools/none-ls.nvim        # Code formatting/linting
- j-hui/fidget.nvim             # LSP progress notifications
```

#### 2. Completion & Snippets
```lua
- hrsh7th/nvim-cmp              # Completion engine
- hrsh7th/cmp-nvim-lsp          # LSP completion source
- hrsh7th/cmp-buffer            # Buffer completion
- hrsh7th/cmp-path              # Path completion
- hrsh7th/cmp-npm               # npm package completion
- L3MON4D3/LuaSnip              # Snippet engine
- saadparwaiz1/cmp_luasnip      # Luasnip completion source
```

#### 3. Syntax & Treesitter
```lua
- nvim-treesitter/nvim-treesitter           # Syntax highlighting
- nvim-treesitter/nvim-treesitter-textobjects # Text objects
```

**Supported Languages**: go, lua, python, typescript, javascript

#### 4. File Navigation & Search
```lua
- nvim-telescope/telescope.nvim     # Fuzzy finder
- nvim-telescope/telescope-fzf-native.nvim # FZF sorter
- nvim-tree/nvim-tree.lua          # File explorer
- nvim-tree/nvim-web-devicons      # File icons
```

#### 5. AI & Code Generation
```lua
- github/copilot.vim               # GitHub Copilot
- CopilotC-Nvim/CopilotChat.nvim  # Copilot chat interface
```

#### 6. Git Integration
```lua
- lewis6991/gitsigns.nvim          # Git signs in gutter
- rhysd/conflict-marker.vim        # Merge conflict markers
```

#### 7. Themes
```lua
- navarasu/onedark.nvim
- rebelot/kanagawa.nvim           # Currently active
- sainnhe/everforest
- catppuccin/nvim
- bluz71/vim-moonfly-colors
```

---

## 🛠️ LSP Configuration

### Critical Fix Applied (2025-09-30)
**Issue**: TypeScript LSP was loading twice, causing "(2X) In progress..." notifications  
**Solution**: Implemented "radical fix" approach

### Current LSP Setup

#### Supported Language Servers
1. **TypeScript/JavaScript** (`ts_ls`)
   - **Binary**: Global npm installation (`typescript-language-server@5.0.0`)
   - **Location**: `/home/tommy/.nvm/versions/node/v22.14.0/bin/typescript-language-server`
   - **Filetypes**: typescript, typescriptreact, javascript, javascriptreact
   - **Root Detection**: tsconfig.json, package.json, jsconfig.json, .git

2. **Python** (`pyright`)
   - **Installation**: Via Mason
   - **Status**: Auto-configured

3. **Lua** (`lua_ls`)
   - **Installation**: Via Mason
   - **Special Config**: Workspace and telemetry settings optimized

#### Mason Tool Installer
```lua
ensure_installed = {
  "lua-language-server",        -- lua
  "pyright",                    -- python
  "terraform-ls",               -- terraform
  -- "typescript-language-server", -- DISABLED: managed manually
  "yaml-language-server",       -- yaml
  "prettier",                   -- prettier formatter
  "pylint",                     -- python linter
  "eslint_d",                   -- eslint
}
```

#### Mason-LSPConfig Handlers
- **Automatic Installation**: DISABLED
- **Special Handling**: Explicitly excludes `ts_ls` and `tsserver` from auto-setup
- **Purpose**: Prevents duplicate LSP instances

### Dependencies
- **Node.js**: v22.14.0 (via NVM)
- **TypeScript**: Global installation
- **TypeScript Language Server**: Global v5.0.0 (NOT via Mason)

---

## ⌨️ Key Mappings

### Leader Key
- **Leader**: `<Space>`
- **Local Leader**: `<Space>`

### Core Navigation
```lua
<C-b>        # Toggle file explorer (NvimTree)
<C-t>        # Find current file in explorer
<C-w>        # Close current buffer
```

### LSP Mappings
```lua
<leader>rn   # Rename symbol
<leader>ca   # Code action
cd           # Go to definition  
cr           # Go to references
ci           # Go to implementation
K            # Hover documentation
<space>f     # Format code
<leader>dp   # Previous diagnostic
<leader>dn   # Next diagnostic
<leader>df   # Show diagnostic float
<leader>dl   # Show diagnostic list
```

### Telescope (Fuzzy Finding)
```lua
<leader>sf   # Search files
<leader>sa   # Search in all files (live_grep)
<leader>sw   # Search current word
<leader>?    # Show keymaps
<leader><space> # Find buffers
<leader>sc   # Search in current buffer
<leader>sh   # Search help
<leader>sd   # Search diagnostics
```

### Git Integration
```lua
<leader>gs   # Git status
<leader>gb   # Git branches
<leader>gc   # Git commits
<leader>gC   # Git buffer commits
```

### AI Integration
```lua
<leader>cc   # Open Copilot Chat
```

### Completion (Insert Mode)
```lua
<Tab>        # Next completion item / expand snippet
<S-Tab>      # Previous completion item / jump back in snippet
<CR>         # Confirm completion
<C-Space>    # Trigger completion
<C-d>        # Scroll docs down
<C-f>        # Scroll docs up
```

---

## 🚀 Installation & Setup

### Prerequisites
```bash
# Required
- Neovim 0.9+
- Git
- Node.js (for TypeScript support)
- npm/yarn (for global packages)

# Optional but recommended
- ripgrep (for telescope grep)
- fd (for telescope file finding)
- make (for telescope-fzf-native)
```

### Installation Steps
1. **Clone repository**:
   ```bash
   git clone <your-repo> ~/.config/nvim
   ```

2. **Install global dependencies**:
   ```bash
   npm install -g typescript-language-server typescript
   ```

3. **First run**:
   ```bash
   nvim
   # Lazy.nvim will automatically install all plugins
   ```

4. **Install LSP servers**:
   - Mason will auto-install configured language servers
   - TypeScript LSP is managed globally (not via Mason)

---

## 🔧 Maintenance Procedures

### Plugin Management
```vim
# Check plugin status
:Lazy

# Update all plugins
:Lazy update

# Install missing plugins
:Lazy install

# Clean unused plugins
:Lazy clean
```

### LSP Management
```vim
# Check LSP status
:LspInfo

# Restart LSP
:LspRestart

# Install language servers via Mason
:Mason
```

### Troubleshooting TypeScript LSP
If TypeScript LSP duplicates again:

1. **Check active clients**:
   ```vim
   :lua vim.print(vim.lsp.get_active_clients())
   ```

2. **Verify global installation**:
   ```bash
   which typescript-language-server
   typescript-language-server --version
   ```

3. **Check Mason doesn't auto-install**:
   - Ensure `typescript-language-server` is commented out in mason-tool-installer
   - Verify mason-lspconfig handlers exclude `ts_ls`

### Configuration Updates
- **Main config**: Edit `init.lua`
- **Keymaps**: Edit `lua/core/keymaps.lua`
- **Options**: Edit `lua/core/options.lua`
- **Plugins**: Edit `lua/plugins/init.lua`

---

## 📊 Performance Considerations

### Startup Optimization
- **Lazy Loading**: Most plugins load on-demand
- **Minimal Init**: Core configuration is lightweight
- **Treesitter**: Compiled parsers for better performance

### Memory Usage
- **LSP**: Only starts servers for active filetypes
- **Completion**: Configured for optimal responsiveness
- **File Explorer**: Opens only when needed

---

## 🔍 Known Issues & Limitations

### Recently Fixed
- ✅ **TypeScript LSP Duplication**: Resolved via radical fix (global npm installation)

### Current Limitations
- **Theme**: Only kanagawa is active (others commented out)
- **Copilot**: Tab mapping disabled in favor of completion
- **Python**: No specific formatting setup beyond prettier

### Potential Improvements
- [ ] Add more language servers (Rust, C++, etc.)
- [ ] Configure null-ls for more formatters
- [ ] Add debugging support (DAP)
- [ ] Implement project-specific configurations

---

## 📚 Additional Resources

### Documentation
- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

### Useful Commands
```vim
:checkhealth          # Check Neovim health
:help <topic>          # Built-in help
:Telescope keymaps     # Browse all keymaps
:Mason                 # Manage language servers
:LspInfo              # Check LSP status
```

---

## 🤝 Contributing

When modifying this configuration:

1. **Test thoroughly** in a separate branch
2. **Update this handover document** with any significant changes  
3. **Pay special attention to LSP configuration** to avoid duplicates
4. **Update lazy-lock.json** when adding/removing plugins
5. **Document any new keybindings** in the appropriate section

---

*Last Updated: 2025-09-30*  
*Configuration Version: Post-TypeScript-LSP-Fix*
