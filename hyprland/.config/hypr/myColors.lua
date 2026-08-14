--[[
================================================================================
#  ЦВЕТОВАЯ СХЕМА, ЭФФЕКТЫ И АНИМАЦИИ (ОБНОВЛЁННАЯ ВЕРСИЯ - myColors.lua)      #
#  Этот файл содержит ваши оригинальные полупрозрачности, фиолетовые тени,       #
#  настройки размытия (blur), а также все кастомные кривые Безье и анимации.     #
#  Подключается в конце hyprland.lua через require("myColors")               #
================================================================================
--]]

hl.config({
    general = {
        -- Цвета рамок обычных окон
        -- Градиент для активного окна (бегущая волна под углом 45 градусов)
        ["col.active_border"] = { 
            colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, 
            angle = 45 
        },
        -- Однотонный цвет для неактивных окон (матовый серый с прозрачностью)
        ["col.inactive_border"] = "rgba(595959aa)",

        -- Цвета рамок для окон, которые запрещено добавлять в группы (nogroup)
        ["col.nogroup_border"] = "rgba(ff99ffee)",
        ["col.nogroup_border_active"] = "rgba(ff00ffee)"
    },

    decoration = {
        -- Закругление углов окон
        rounding = 10,

        -- Полупрозрачность для активных и неактивных окон (как в вашем старом конфиге!)
        active_opacity = 0.96,
        inactive_opacity = 0.8,

        -- Густые фиолетовые тени для плавающих окон (создают эффект стильного неонового свечения)
        shadow = {
            enabled = true,
            range = 20,              -- Большой радиус для мягкого и глубокого свечения
            render_power = 3,        -- Сила спада тени
            color = "rgba(aa0080ff)", -- Насыщенный фиолетовый/пурпурный цвет тени
            color_inactive = "rgba(00000000)" -- Тени скрываются у неактивных окон
        },

        -- Настройка внутреннего свечения (Glow)
        glow = {
            enabled = false,
            range = 10,
            render_power = 3,
            color = "rgba(33ccffee)"
        },

        -- Настройки Kawase-размытия фона (Blur)
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696
        }
    },

    -- Настройки оформления вкладок (групп окон)
    group = {
        ["col.border_active"] = "rgba(66ffff00)",
        ["col.border_inactive"] = "rgba(66777700)",
        ["col.border_locked_active"] = "rgba(66ff5500)",
        ["col.border_locked_inactive"] = "rgba(66775500)",

        -- Стили панели вкладок (Groupbar)
        groupbar = {
            ["col.active"] = "rgba(66ffff00)",
            ["col.inactive"] = "rgba(66777700)",
            ["col.locked_active"] = "rgba(66ff5500)",
            ["col.locked_inactive"] = "rgba(66775500)"
        }
    }
})

--------------------------------------------------------------------------------
-- КРИВЫЕ БЕЗЬЕ (CUBIC BEZIER CURVES)
-- Перенос ваших кастомных кривых на новый синтаксис hl.curve()
--------------------------------------------------------------------------------

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })


--------------------------------------------------------------------------------
-- СИСТЕМНЫЕ АНИМАЦИИ (ANIMATIONS)
-- Привязка переходов к кривым Безье с использованием hl.animation()
--------------------------------------------------------------------------------

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
