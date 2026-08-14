#!/bin/bash
# Получаем ключ из аргумента командной строки
key=$1

# Определяем путь к файлу в зависимости от ключа
if [ "$key" = "--bash" ]; then
    file=~/.config/waybar/bash_commands_js.html
    #title="Команды bash"
    #yad --wrap --html --no-buttons --width=600 --height=400 --title="$title" < $file
    firefox --new-window $file
else
    file=~/.config/waybar/show_shortcuts.txt
    title="Горячие клавиши"
    yad --wrap --text-info --no-buttons --width=600 --height=400 --title="$title" < $file
fi


