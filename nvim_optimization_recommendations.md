# Khuyến nghị tối ưu hóa Neovim Configuration

## 📊 Phân tích hiệu suất hiện tại

**Thời gian khởi động**: ~69ms (khá chậm cho cấu hình cơ bản)  
**Số lượng plugins**: 114 plugins  
**Các plugins chậm nhất**:
- gitsigns.nvim: ~1.6ms
- copilot.vim: autoload chậm  
- LuaSnip: nhiều module load

## 🎯 Các vấn đề chính đã phát hiện

### 1. Plugin Overload
- 114 plugins là quá nhiều cho setup cơ bản
- Nhiều theme plugins không sử dụng
- Duplicate functionality (ví dụ: auto-pairs vs nvim-cmp autopairs)

### 2. Lazy Loading không tối ưu
- Gitsigns load ngay khi khởi động
- Copilot autoload không cần thiết
- Nhiều completion sources load cùng lúc

### 3. Performance Settings chưa tối ưu
- updatetime có thể giảm xuống
- Một số tính năng UI có thể tắt

## 🚀 Khuyến nghị tối ưu hóa

### A. Loại bỏ plugins không cần thiết

#### Themes (chỉ giữ kanagawa)
```lua
-- XÓA các themes không dùng:
-- "navarasu/onedark.nvim"
-- "sainnhe/everforest" 
-- "catppuccin/nvim"
-- "bluz71/vim-moonfly-colors"
```

#### Completion overlap
```lua
-- XÓA duplicate:
-- "David-Kunz/cmp-npm" (đã có hrsh7th/cmp-npm)
```

### B. Cải thiện Lazy Loading

#### Git Signs - lazy load khi mở git file
```lua
{
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('gitsigns').setup{}
  end
}
```

#### Copilot - lazy load
```lua
{
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true
  end
}
```

#### Treesitter - lazy load
```lua
{
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}
```

### C. Tối ưu Performance Options

#### Trong lua/core/options.lua - thêm:
```lua
-- Advanced performance
opt.updatetime      = 100           -- giảm từ 250
opt.timeoutlen      = 300           -- giảm từ 500
opt.ttimeoutlen     = 10            -- thêm mới
opt.redrawtime      = 1000          -- giảm từ 1500
opt.synmaxcol       = 200           -- giảm từ 240
opt.re              = 1             -- regex engine cũ (nhanh hơn)

-- Disable một số tính năng không cần thiết
opt.backup          = false
opt.writebackup     = false
opt.swapfile        = false
opt.undofile        = true          -- chỉ dùng undofile
```

### D. LSP Optimization

#### Giảm diagnostic update frequency:
```lua
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = false,
    virtual_text = { prefix = "●" },
  }
)
```

### E. Completion Optimization

#### Giảm số completion sources:
```lua
-- Chỉ giữ essentials
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'luasnip' },
  { name = 'path' },
}, {
  { name = 'buffer', keyword_length = 3 },
})
```

## 🏃‍♂️ Quick Wins (có thể áp dụng ngay)

### 1. Tối ưu ngay lập tức
```bash
# Comment out các theme không dùng trong lua/plugins/init.lua
sed -i 's/^  "navarasu\/onedark.nvim"/  -- "navarasu\/onedark.nvim"/' lua/plugins/init.lua
sed -i 's/^  "sainnhe\/everforest"/  -- "sainnhe\/everforest"/' lua/plugins/init.lua
sed -i 's/^  "catppuccin\/nvim"/  -- "catppuccin\/nvim"/' lua/plugins/init.lua
sed -i 's/^  "bluz71\/vim-moonfly-colors"/  -- "bluz71\/vim-moonfly-colors"/' lua/plugins/init.lua
```

### 2. Update performance settings
```bash
# Backup current options
cp lua/core/options.lua lua/core/options.lua.bak

# Add performance improvements
cat >> lua/core/options.lua << 'PERF'

-- Additional Performance Optimizations
opt.updatetime      = 100
opt.timeoutlen      = 300  
opt.ttimeoutlen     = 10
opt.redrawtime      = 1000
opt.re              = 1
opt.backup          = false
opt.writebackup     = false
opt.swapfile        = false
PERF
```

## 📈 Expected Improvements

Sau khi áp dụng các tối ưu hóa này:

- **Startup time**: từ ~69ms xuống ~35-40ms (-40%)
- **Memory usage**: giảm ~20-30% 
- **Response time**: cải thiện trong insert mode
- **Plugin count**: từ 114 xuống ~85-90

## ⚠️ Lưu ý

1. **Backup trước khi thay đổi**: 
   ```bash
   cp -r ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Test từng thay đổi một** để đảm bảo không break functionality

3. **Sau khi thay đổi**:
   ```bash
   nvim --headless -c 'Lazy! sync' -c 'qall'
   ```

4. **Measure performance**:
   ```bash
   nvim --startuptime startup_after.log --headless -c 'qall'
   ```
