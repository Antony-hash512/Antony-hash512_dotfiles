# My Dotfiles / Мои дотфайлы

[![Dotfiles](https://img.shields.io/badge/GNU/Linux-dotfiles-blue.svg)](https://github.com/topics/dotfiles) 


[English](#english) | [Русский](#русский)

---

## English

### Easy Web Access
The repository structure corresponds to the actual file paths relative to your home directory (when using Stow). You can simply browse the repository on GitHub/GitLab, find the config file you are interested in (e.g., `neovim/.config/nvim/init.lua`), and copy the content directly to your local files.

### Directory Structure & Hidden Files
Each module in this repository mirrors the actual file structure of your `$HOME` directory. For instance, the file `neovim/.config/nvim/init.lua` maps effectively to `~/.config/nvim/init.lua`.

**Note on Hidden Files:**
Files and directories starting with a dot (`.`) are hidden by default in Linux.
- **Terminal:** Use `ls -a` / `tree -a` to see them.
- **File Managers:** In most GUI managers (GNOME Files, Dolphin, Thunar), press `Ctrl+H` to toggle visibility.
- **Console File Managers:**
  - **ranger:** Press `z`, then `h`.
  - **yazi:** Press `.`
  - **lf:** Press `z`, then `h` (if it doesn't work, try `.`)
- **Dual-Pane File Managers:**
  - **Midnight Commander (mc):** Press `Alt + .` (or `Esc + .`)
  - **Double Commander:** Press `Ctrl + .` or `Ctrl + Shift + .`
  - **Far2l:** `F9` -> `Options` -> `Panel settings` -> `Show hidden files`

### Installation via GNU Stow

You can install configuration modules individually or all at once using GNU Stow.

**Install a single module:**
```bash
stow <module_name>
# Example:
stow neovim
```

**Install all modules:**
```bash
# This installs all packages in the current directory
stow */
```

### Modules Description & Nuances

#### Fish 🐟

**Nuances:**
- **External Functions:** The core functions for specific functionalities are not stored directly in this repo's files but are pulled from a separate repository as a submodule.
- **Repositories:**
  - Standard version: [Fish_functions_collection](https://github.com/Antony-hash512/Fish_functions_collection)
  - NAS/Synology DSM version: [Fish_functions_collection_for_DSM](https://github.com/Antony-hash512/Fish_functions_collection_for_DSM) (optimized for network storage environments)

#### Git 🐙
A modular Git configuration setup.

**Integration:**
To utilize this configuration, you simply need to include the file in your main config.

Don't forget to add the following lines:
```ini
[include]
    path = ~/.config/git/antony-hash512.config
```
to the beginning or the end of your global git config file `~/.gitconfig` or `~/.config/git/config`.

**Note:** Git configurations follow a "last one wins" rule:
- If you place this at the end of the file, these settings will override any previous configurations.
- If you place this at the beginning, your existing settings below will take precedence.

**Why is this necessary?**
Git configuration files often mix purely structural/preference settings (aliases, color settings, diff tools) with highly personalized data (user email, names, signing keys). By keeping this repository's config separate and using the `[include]` directive, we avoid hardcoding personal identity information into the shared config. This allows you to adopt the "functional" settings while keeping your identity private and local in your main `.gitconfig`.

**Dependencies & Tools:**
- **[git-delta](https://github.com/dandavison/delta):** Used as the default pager for beautiful, syntax-highlighted diffs.
- **Meld:** Set as the default visual diff tool.
- **CLI environments (SSH/VPS/TTY):** If you're working on a headless system/VPS/remote machine via SSH or only have a bare TTY or don't want to leave the terminal, open `antony-hash512.config`, comment out `tool = meld`, and uncomment `tool = vimdiff` or `tool = nvimdiff` to ensure diffs work correctly without a GUI.

#### Neovim 📝
A lightweight, efficient Neovim configuration written in Lua.
- **Path:** `.config/nvim/init.lua`
- It is designed to be easily readable via web browser so you can copy specific snippets (mappings, plugin setups, etc.) directly into your own `init.lua` without needing to fork the whole setup. However, you can also install it entirely. In this case, you need to install plugins using Packer:
  1. Install Packer:
     ```bash
     git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
     ```
  2. Open Neovim and run `:PackerSync` to install and synchronize all plugins.
> ⚠️ **Arrow Keys vs HJKL (pay attention):** The file `keymaps/disable_arrows.lua` disables arrow keys in Normal/Visual modes to force the habit of using `hjkl` navigation. If you prefer using arrow keys, **do not copy this file** (or delete it if installed).

#### MPV 🎬
Configuration for the MPV media player.
- **Path:** `.config/mpv/mpv.conf`
- Includes optimized settings for high-quality video playback and UI improvements.
- **Scripts:** Includes `force_external.lua` (in `.config/mpv/scripts/`), which allows automatically loading matching subtitles and audio tracks from external subdirectories.

#### Gemini + Antigravity 🤖
Context and memory files for AI Assistants (Gemini, Antigravity).
- **Path:** `.gemini/GEMINI.md`
- Contains persistent instructions and context for AI sessions.
- **IDE Configuration:** Includes a lightweight configuration (similar to VS Code's `settings.json`) optimized for AI-assisted coding.
  - **Spellchecking:** Ensure you have spellchecking plugins installed.
  - **Compatibility:** This config is designed for this environment but is largely standard and compatible with other VS Code-based IDEs.
- **MCP:** A ready-made MCP server configuration for Context7 has also been added for Antigravity (you only need to manually insert your user API key; instead of the key in the configuration, there is a link to the page where you can obtain it).


#### Templates 📄
A collection of boilerplates and skeletons for quickly creating new files.
- **Path:** `~/Templates/`
- Includes templates for:
  - Shell scripts (bash, sh, fish)
  - Python scripts
  - HTML and XML files
  - Desktop entries (`.desktop`)
  - Licenses (MIT, GPLv3)
- **Integration:** These templates automatically appear in the "Create New Document" context menu in many Linux file managers (GNOME Files, Dolphin, Thunar).

#### Legacy 🕰️
Contains basic configurations for tools I used previously and only access occasionally. The configs here are minimal.



---

## Русский

### Простое использование (Copy-Paste)
Структура репозитория специально сделана прозрачной. Вы можете просто открыть нужный конфиг в браузере (например, зайти в папку `neovim` -> `.config` -> `nvim` -> `init.lua`) и скопировать любой понравившийся фрагмент кода или настроек прямо в свои конфиги. Если вам нужна только пара настроек, то нет необходимости клонировать весь репозиторий

### Структура директорий и скрытые файлы
Каждый модуль в этом репозитории зеркалирует реальную структуру файлов вашего домашнего каталога (`$HOME`). Например, файл `neovim/.config/nvim/init.lua` соответствует пути `~/.config/nvim/init.lua`.

**Скрытые файлы:**
Файлы и папки, начинающиеся с точки (`.`), по умолчанию скрыты в Linux.
- **В терминале:** Используйте команду `ls -a` / `tree -a`, чтобы увидеть их.
- **В файловых менеджерах:** В большинстве менеджеров (GNOME Files, Dolphin, Thunar) нажмите `Ctrl+H` для переключения видимости.
- **В консольных менеджерах:**
  - **ranger:** Нажмите `z`, затем `h`.
  - **yazi:** Нажмите `.`
  - **lf:** Нажмите `z`, затем `h` (если не работает, попробуйте `.`)
- **Двухпанельные менеджеры:**
  - **Midnight Commander (mc):** Нажмите `Alt + .` (или `Esc + .`)
  - **Double Commander:** Нажмите `Ctrl + .` или `Ctrl + Shift + .`
  - **Far2l:** `F9` -> `Options` -> `Panel settings` -> `Show hidden files`

### Установка через GNU Stow

Вы можете установить конфигурационные модули как по отдельности, так и все сразу (оптом), используя GNU Stow.

**Установка отдельного модуля:**
```bash
stow <имя_модуля>
# Пример:
stow neovim
```

**Установка всех модулей сразу:**
```bash
# Эта команда установит все пакеты, находящиеся в текущей директории
stow */
```

### Описание модулей и нюансы

#### Fish 🐟

**Нюансы:**
- **Внешние функции:** Основные функции вынесены в отдельный репозиторий и подключены сюда в виде сабмодуля (submodule).
- **Ссылки на репозитории:**
  - Основной набор функций: [Fish_functions_collection](https://github.com/Antony-hash512/Fish_functions_collection)
  - Версия для NAS/DSM: [Fish_functions_collection_for_DSM](https://github.com/Antony-hash512/Fish_functions_collection_for_DSM) (адаптирована для сетевых хранилищ Synology и др.)

#### Git 🐙
Модульная конфигурация Git.

**Подключение:**
Для использования этого конфига необходимо добавить инструкцию include в ваш основной файл настроек.

Не забудьте добавить данную пару строк:
```ini
[include]
    path = ~/.config/git/antony-hash512.config
```
в начало или конец вашего глобального git-конфига `~/.gitconfig` или `~/.config/git/config`.

**Примечание:** В конфигурациях Git действует правило "последний побеждает" (last one wins):
- Если вы поместите это в конец файла, эти настройки переопределят любые предыдущие конфигурации.
- Если вы поместите это в начало, ваши существующие настройки ниже будут иметь приоритет.

**Зачем это нужно (Развернуто):**
В Git конфигурационных файлах часто смешиваются общие настройки (алиасы, цвета, настройки diff/merge, поведение команд) и сугубо персональные данные (имя пользователя, email, ключи подписи GPG/SSH). 
Я использую подход с `[include]`, потому что в противном случае пришлось бы "зашивать" свои личные данные в публичный файл конфига, либо вычищать их каждый раз. Подключая файл через include, вы получаете все мои настройки алиасов и инструментов, но ваши личные данные (имя, почта) остаются в вашем локальном `.gitconfig` и имеют приоритет (или наоборот, дополняются), что позволяет безопасно использовать этот конфиг любому пользователю.

**Зависимости и инструменты:**
- **[git-delta](https://github.com/dandavison/delta):** Используется как стандартный пейджер для красивого отображения diff с подсветкой синтаксиса.
- **Meld:** Установлен как инструмент сравнения по умолчанию.
- **Работа в консоли (SSH/VPS/TTY):** Если вы работаете на удаленной машине, headless-системе или в чистом TTY или просто не хотите покидать терминал, загляните в `antony-hash512.config`, закомментируйте `tool = meld` и раскомментируйте `tool = vimdiff` или `tool = nvimdiff`. Это позволит комфортно сравнивать файлы без использования графического интерфейса.

#### Neovim 📝
Легковесная и эффективная конфигурация Neovim на Lua.
- **Путь к файлу:** `.config/nvim/init.lua`
- Конфиг написан так, что вы можете просто открыть его в веб-интерфейсе репозитория, просмотреть код и скопировать нужные куски (биндинги клавиш, настройки плагинов) к себе, не устанавливая весь "dotfiles" целиком. Но можно и установить целиком, при этом нужно установить плагины при помощи Packer:
 1. Установите Packer:
   ```bash
   git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```
2. Запустите Neovim и выполните команду `:PackerSync` для установки и синхронизации всех плагинов.
> ⚠️ **Стрелки против HJKL (имейте в виду):** Файл `keymaps/disable_arrows.lua` отключает использование стрелок в нормальном и визуальном режимах, чтобы форсировать привычку к навигации через `hjkl`. Если вам удобнее использовать стрелки, **не копируйте этот файл** (или удалите его, если он уже установлен).
#### MPV 🎬
Конфиг для медиаплеера MPV.
- **Путь к файлу:** `.config/mpv/mpv.conf`
- Включает оптимизированные настройки для высокого качества воспроизведения и улучшения интерфейса.
- **Скрипты:** Включен скрипт `force_external.lua` (в `.config/mpv/scripts/`), который позволяет автоматически подгружать субтитры и аудиодорожки из внешних подкаталогов.

#### Gemini + Antigravity 🤖
Файлы контекста и "памяти" для AI-ассистентов (Gemini, Antigravity).
- **Путь к файлу:** `.gemini/GEMINI.md`
- Содержит инструкции и правила, которые загружаются в контекст AI.
- **Конфигурация IDE:** Модуль содержит небольшой конфиг (по типу `settings.json` для VS Code), оптимизированный для работы с AI.
  - **Проверка орфографии:** Не забудьте установить плагины для проверки правописания (русский и английский словари).
  - **Совместимость:** Конфигурация по большей части стандартная и скорее всего подойдет для других IDE на базе VS Code.
- **MCP:** Для Antigravity также добален готовый конфиг MCP-сервера Context7 (в него надо только вручную вставить пользовательских API-ключ, вместо ключа в конфиге ссылка на страницу, где его можно получить).

#### Шаблоны (Templates) 📄
Коллекция заготовок и скелетов файлов для быстрого создания новых документов.
- **Путь:** `~/Templates/`
- Содержит шаблоны для:
  - Скриптов (bash, sh, fish)
  - Python-скриптов
  - HTML и XML файлов
  - Файлов рабочего стола (`.desktop`)
  - Лицензий (MIT, GPLv3)
- **Интеграция:** Эти файлы автоматически появляются в контекстном меню "Создать документ" (Create New Document) в большинстве файловых менеджеров Linux (GNOME Files, Dolphin, Thunar).

#### Legacy 🕰️
Содержит базовые конфигурации для инструментов, которые я использовал ранее и к которым обращаюсь лишь изредка. Конфиги здесь минимальны.


