#!/bin/bash

# Функция запуска: проверяет, активен ли uwsm
start() {
    if command -v uwsm > /dev/null && pgrep -x uwsm > /dev/null; then
        uwsm app -- "$@"
    else
        "$@" &
    fi
}

# --- СИСТЕМНОЕ ---
start /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
start /usr/lib/xdg-desktop-portal-hyprland
start nm-applet
start mako

# --- ИНТЕРФЕЙС ---
start waybar
start hyprshell run   # <-- Запускаем демон Hyprshell (он сам ловит Alt+Tab)
start nwg-dock-hyprland -d -p bottom -i 48

# --- ОБОИ ---
# Раскомментируйте, если используете swaybg или hyprpaper
# start swaybg -i ~/Pictures/wallpaper.jpg
