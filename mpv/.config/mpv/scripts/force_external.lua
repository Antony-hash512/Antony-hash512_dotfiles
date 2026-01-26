-- ~/.config/mpv/scripts/autoload_smart.lua
-- Ultimate версия: Подгружает все, называет дорожки именами папок

local utils = require 'mp.utils'
local msg = require 'mp.msg'

-- НАСТРОЙКИ
local MAX_DEPTH = 3

-- Расширения
local audio_exts = {
    mka=1, ac3=1, dts=1, flac=1, wav=1, mp3=1, ogg=1, m4a=1, 
    opus=1, aac=1, wma=1, alac=1
}
local sub_exts = {
    srt=1, ass=1, sub=1, vtt=1
}

-- Хелпер: извлекает имя родительской папки для красивого названия
-- /path/to/Rus sound/[Persona99]/file.mka -> возвращает "[Persona99]"
local function get_folder_name(full_path)
    local parts = utils.split_path(full_path) -- возвращает (dir, file)
    local dir = parts
    -- Убираем последний слеш, если есть
    if dir:sub(-1) == "/" then dir = dir:sub(1, -2) end
    -- Ищем позицию последнего слеша
    local last_slash = dir:match("^.*()/")
    if last_slash then
        return dir:sub(last_slash + 1)
    end
    return "External"
end

local function scan_directory(path, depth, target_filename)
    if depth > MAX_DEPTH then return end

    -- 1. Сначала подпапки
    local dirs = utils.readdir(path, "dirs")
    if dirs then
        for _, dir in ipairs(dirs) do
            if dir ~= "." and dir ~= ".." then
                scan_directory(utils.join_path(path, dir), depth + 1, target_filename)
            end
        end
    end

    -- 2. Файлы
    local files = utils.readdir(path, "files")
    if files then
        for _, file in ipairs(files) do
            local ext = file:match("^.+(%.[^%d]+)$")
            if ext then
                ext = ext:sub(2):lower()
                -- Поиск по имени (без спецсимволов)
                if string.find(file, target_filename, 1, true) then
                    
                    local full_path = utils.join_path(path, file)
                    -- Получаем имя папки (например "[Persona99]")
                    local title = get_folder_name(full_path)

                    if audio_exts[ext] then
                        msg.info("Loaded audio: " .. file .. " as " .. title)
                        -- "auto" - просто добавить в список (не переключать насильно)
                        -- title - задать имя дорожки в меню
                        mp.commandv("audio-add", full_path, "auto", title, "ru")
                        
                    elseif sub_exts[ext] then
                        msg.info("Loaded sub: " .. file .. " as " .. title)
                        mp.commandv("sub-add", full_path, "auto", title, "ru")
                    end
                end
            end
        end
    end
end

local function load_external_tracks()
    local path = mp.get_property("path")
    if not path then return end
    
    local work_dir = utils.split_path(path)
    local filename = mp.get_property("filename/no-ext")
    
    if filename and work_dir then
        scan_directory(work_dir, 1, filename)
    end
end

mp.register_event("start-file", load_external_tracks)
