
-- disable_arrows.lua

-- Отключаем стрелки во всех режимах
local modes = { 'n', 'v' }
local arrows = { ['<Up>'] = '', ['<Down>'] = '', ['<Left>'] = '', ['<Right>'] = '' }

for _, mode in ipairs(modes) do
  for key, _ in pairs(arrows) do
    vim.keymap.set(mode, key, '<Nop>', { noremap = true, silent = true })
  end
end
