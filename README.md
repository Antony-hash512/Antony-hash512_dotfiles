# Dotfiles / Конфигурационные файлы

[English](#english) | [Русский](#русский)

---

## English

### Easy Web Access
The repository structure corresponds to the actual file paths relative to your home directory (when using Stow). You can simply browse the repository on GitHub/GitLab, find the config file you are interested in (e.g., `neovim/.config/nvim/init.lua`), and copy the content directly to your local files.

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
My comprehensive configuration for the Fish shell.

**Nuances:**
- **External Functions:** The core functions for specific functionalities are not stored directly in this repo's files but are pulled from a separate repository as a submodule.
- **Repositories:**
  - Standard version: [Fish_functions_collection](https://github.com/Antony-hash512/Fish_functions_collection)
  - NAS/Synology DSM version: [Fish_functions_collection_for_DSM](https://github.com/Antony-hash512/Fish_functions_collection_for_DSM) (optimized for network storage environments)

#### Git 🐙
A modular Git configuration setup.

**Integration:**
To utilize this configuration, you simply need to include the file in your main config. Add the following lines to the beginning or end of your global `.gitconfig` or `~/.config/git/config`:

```ini
[include]
    path = ~/.config/git/antony-hash512.config
```

**Why is this necessary?**
Git configuration files often mix purely structural/preference settings (aliases, color settings, diff tools) with highly personalized data (user email, names, signing keys). By keeping this repository's config separate and using the `[include]` directive, we avoid hardcoding personal identity information into the shared config. This allows you to adopt the "functional" settings while keeping your identity private and local in your main `.gitconfig`.

#### Neovim 📝
A lightweight, efficient Neovim configuration written in Lua.
- **Path:** `.config/nvim/init.lua`
- It is designed to be easily readable via web browser so you can copy specific snippets (mappings, plugin setups, etc.) directly into your own `init.lua` without needing to fork the whole setup.

#### MPV 🎬
Configuration for the MPV media player.
- **Path:** `.config/mpv/mpv.conf`
- Includes optimized settings for high-quality video playback and UI improvements.

#### Gemini + Antigravity 🤖
Context and memory files for AI Assistants (Gemini, Antigravity).
- **Path:** `.gemini/GEMINI.md`
- Contains persistent instructions and context for AI sessions.



---

## Русский

### Простое использование (Copy-Paste)
Структура репозитория специально сделана прозрачной. Вы можете просто открыть нужный конфиг в браузере (например, зайти в папку `neovim` -> `.config` -> `nvim` -> `init.lua`) и скопировать любой понравившийся фрагмент кода или настроек прямо в свои конфиги. Нет необходимости клонировать весь репозиторий, если вам нужна только пара настроек.

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
Моя подробная конфигурация для командной оболочки Fish.

**Нюансы:**
- **Внешние функции:** Основные функции вынесены в отдельный репозиторий и подключены сюда в виде сабмодуля (submodule).
- **Ссылки на репозитории:**
  - Основной набор функций: [Fish_functions_collection](https://github.com/Antony-hash512/Fish_functions_collection)
  - Версия для NAS/DSM: [Fish_functions_collection_for_DSM](https://github.com/Antony-hash512/Fish_functions_collection_for_DSM) (адаптирована для сетевых хранилищ Synology и др.)

#### Git 🐙
Модульная конфигурация Git.

**Подключение:**
Для использования этого конфига необходимо добавить инструкцию include в ваш основной файл настроек. Вставьте следующее в начало или конец вашего `~/.gitconfig` или `~/.config/git/config`:

```ini
[include]
    path = ~/.config/git/antony-hash512.config
```

**Зачем это нужно (Развернуто):**
В Git конфигурационных файлах часто смешиваются общие настройки (алиасы, цвета, настройки diff/merge, поведение команд) и сугубо персональные данные (имя пользователя, email, ключи подписи GPG/SSH). 
Я использую подход с `[include]`, потому что в противном случае пришлось бы "зашивать" свои личные данные в публичный файл конфига, либо вычищать их каждый раз. Подключая файл через include, вы получаете все мои настройки алиасов и инструментов, но ваши личные данные (имя, почта) остаются в вашем локальном `.gitconfig` и имеют приоритет (или наоборот, дополняются), что позволяет безопасно использовать этот конфиг любому пользователю.

#### Neovim 📝
Легковесная и эффективная конфигурация Neovim на Lua.
- **Путь к файлу:** `.config/nvim/init.lua`
- Конфиг написан так, что вы можете просто открыть его в веб-интерфейсе репозитория, просмотреть код и скопировать нужные куски (биндинги клавиш, настройки плагинов) к себе, не устанавливая весь "dotfiles" целиком.

#### MPV 🎬
Конфиг для медиаплеера MPV.
- **Путь к файлу:** `.config/mpv/mpv.conf`
- Включает оптимизированные настройки для высокого качества воспроизведения и улучшения интерфейса.

#### Gemini + Antigravity 🤖
Файлы контекста и "памяти" для AI-ассистентов (Gemini, Antigravity).
- **Путь к файлу:** `.gemini/GEMINI.md`
- Содержит инструкции и правила, которые загружаются в контекст AI.


