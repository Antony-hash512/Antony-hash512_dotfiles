
-- Отключение стрелок, чтобы привыкнуть к буквенным перемещениям
require('keymaps.disable_arrows')

-- Включение подсветки синтаксиса (не требуется в Neovim, включено по умолчанию)
-- vim.cmd("syntax on")

-- Включение номеров строк
vim.opt.number = true
vim.opt.relativenumber = false -- относительные номера на остальных строках

-- Отображение скрытых символов
vim.opt.list = true
vim.opt.listchars = { tab = "» »", space = "·" }

-- Подключение системного буфера обмена
vim.opt.clipboard = "unnamedplus"

-- Настройки табуляции
vim.opt.tabstop = 4        -- Отображение табуляции как 4 пробела
vim.opt.softtabstop = 0    -- Отключение автоматического замещения табов пробелами
vim.opt.shiftwidth = 4     -- Размер отступа при сдвигах (>> и <<)
vim.opt.expandtab = false  -- Использовать реальные табуляции (\t), а не пробелы



-- Загрузка packer
vim.cmd [[packadd packer.nvim]]
--  paru -S nvim-packer-git
-- :PackerInstall -- установка плагинов
-- :PackerSync -- их обновление
-- :PackerClean -- удаление неиспользуемых плагинов
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'     -- сам packer
  use 'github/copilot.vim'         -- copilot
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons' -- иконки
  use 'nvim-lualine/lualine.nvim'      -- статусбар внизу
  use 'akinsho/bufferline.nvim'        -- вкладки вверху (как в VSCode)
  -- use 'nvim-telescope/telescope.nvim'  -- поиск файлов
  use "folke/tokyonight.nvim" -- тема оформления
  use { "catppuccin/nvim", as = "catppuccin" } -- тема оформления
    -- 🔍 Подсветка различий внутри строк при сравнении
  use 'chrisbra/vim-diff-enhanced'
  use 'rickhowe/diffchar.vim'
end)

-- Автокоманда: пересобрать packer при изменении init.lua
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]]
-- nvim-web-devicons
pcall(function()
  require('nvim-web-devicons').setup()
end)

-- nvim-tree
pcall(function()
  require('nvim-tree').setup()
end)
-- vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', {
  expr = true,
  silent = true,
  noremap = true,
})

-- lualine
pcall(function()
  require('lualine').setup {
    options = {
      theme = 'auto',
      icons_enabled = true,
      section_separators = '',
      component_separators = '',
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      always_divide_middle = true,
      globalstatus = false,
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {
        function()
          return '🎨' .. (vim.g.colors_name or 'default')
        end
      },
      lualine_z = {'location'}
    }
  }
end)
-- bufferline
pcall(function()
  require('bufferline').setup {}
end)

--print(vim.g.colors_name)

-- Тёмная и светлая темы
vim.g.catppuccin_flavour = "latte" -- светлая версия
require("catppuccin").setup()
vim.cmd.colorscheme("catppuccin")

local dark_theme = "tokyonight"
local light_theme = "catppuccin"


local function set_theme_by_time()
  local hour = tonumber(os.date("%H"))
  if hour >= 8 and hour < 20 then
    vim.o.background = "light"
    vim.g.catppuccin_flavour = "latte"
    require("catppuccin").setup()
    vim.cmd.colorscheme("catppuccin")
  else
    vim.o.background = "dark"
    vim.cmd.colorscheme("tokyonight")
  end
end


-- Вызов при запуске
set_theme_by_time()

-- Переключение по F5
vim.keymap.set('n', '<F5>', function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.g.catppuccin_flavour = "latte"
    pcall(function()
      require("catppuccin").setup()
    end)
    vim.cmd.colorscheme(light_theme)
  else
    vim.o.background = "dark"
    vim.cmd.colorscheme(dark_theme)
  end
  print("🌗 Theme: " .. vim.o.background)
end, { noremap = true, silent = true })

vim.g.mapleader = ' '  -- Можно оставить как есть

-- 🔁 Переключение вкладок (буферов)
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

-- ❌ Закрытие текущего буфера
vim.keymap.set('n', '<C-w>', function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local current = vim.api.nvim_get_current_buf()

  if #bufs > 1 then
    vim.cmd('bnext')
    vim.cmd('bd ' .. current)
  else
    vim.cmd('q')  -- последний буфер, закрываем окно
  end
end, { noremap = true, silent = true })

-- ❌ Закрытие текущего буфера без сохранения
vim.keymap.set('n', '<C-w><C-w>', function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local current = vim.api.nvim_get_current_buf()

  if #bufs > 1 then
    vim.cmd('bnext')
    vim.cmd('bd! ' .. current)
  else
    vim.cmd('q!')  -- последний буфер, закрываем окно
  end
end, { noremap = true, silent = true })
-- 📁 Файловое дерево

vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })   -- Открыть/скрыть
vim.keymap.set('n', '<C-\\>', ':NvimTreeFocus<CR>', { noremap = true, silent = true })    -- Фокус на дерево

-- 🔍 Поиск файлов (Ctrl + P)
-- vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })

-- 🔍 Поиск по строкам в проекте (как Ctrl + Shift + F)
-- vim.keymap.set('n', '<S-C-f>', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- 🧠 Команды (Ctrl + Shift + P)
-- vim.keymap.set('n', '<S-C-p>', ':Telescope commands<CR>', { noremap = true, silent = true })

-- 📜 Переключение между буферами (Tab уже есть)
-- vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { noremap = true })
-- vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { noremap = true })
-- vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { noremap = true })

-- 🪟 Сплиты (разделение окон как в VSCode)
vim.keymap.set('n', '<C-\\><C-v>', ':vsplit<CR>', { noremap = true, silent = true })  -- вертикальный
vim.keymap.set('n', '<C-\\><C-s>', ':split<CR>', { noremap = true, silent = true })   -- горизонтальный
vim.keymap.set('n', '<C-q>', function()
  if vim.fn.winnr('$') > 1 then
    vim.cmd('q')
  else
    print("Use :q to close the last window of split")
  end
end, { noremap = true, silent = true })

-- ⬅️➡️ Перемещение между окнами (как в tmux/VSCode)
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })

-- 🖥️ Открытие терминала в сплите или новом табе
-- для начала работы в терминале нужно нажать i для перехода в режим ввода
-- для выхода из терминала используйте <C-d> или exit
vim.keymap.set('n', '<C-t><C-s>', ':split | terminal<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-t><C-v>', ':vsplit | terminal<CR>', { noremap = true, silent = true }) -- vertical
vim.keymap.set('n', '<C-t>', ':tabnew | terminal<CR>', { noremap = true, silent = true }) -- tab

-- vim.opt.shell = "/bin/bash"
-- vim.opt.shell = vim.fn.executable("zsh") == 1 and "zsh" or "bash"

-- Открытие конфигурации Neovim в новом табе
vim.keymap.set('n', '<C-e><C-d>', ':tabnew ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
-- Открытие конфигурации Fish в новом табе
vim.keymap.set('n', '<C-f><C-i>', ':tabnew ~/.config/fish/config.fish<CR>', { noremap = true, silent = true })
-- + Новый пустой таб
vim.keymap.set('n', '<C-n>', ':tabnew<CR>', { noremap = true, silent = true })


-- 🔧 Включение улучшенного сравнения строк
vim.g.DiffUseDiffEnhanced = 1

