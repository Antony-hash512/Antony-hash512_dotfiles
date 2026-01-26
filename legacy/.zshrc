export LANG=en_US.UTF-8
export MANPATH=/usr/share/man/ru:/usr/share/man:/usr/local/share/man
#export LANGUAGE=ru_RU:en_US
#export LC_MESSAGES=ru_RU.UTF-8
export MANOPT='-L ru_RU.UTF-8:en_US.UTF-8'

# аллиас для sudo-rs
export SUDO_RS_ENABLED=1

if [[ "$SUDO_RS_ENABLED" == 1 ]]; then
  sudo() { command sudo-rs "$@"; }
fi

#source ~/.config/user-dirs.dirs

alias llf='ls -laF'
unset ARGV0

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}


# Функция для проверки arch-chroot
function check_chroot() {
    if [ -f /etc/arch-chroot ]; then
        echo "[CHROOT]"
    fi
}

# Переименовываем функцию set_prompt в prompt_builder
function prompt_builder {
    # Определение цветов для zsh
    local RED=$'%{\e[0;31m%}'
    local LIGHT_RED=$'%{\e[1;31m%}'
    local GREEN=$'%{\e[0;32m%}'
    local LIGHT_GREEN=$'%{\e[1;32m%}'
    local YELLOW=$'%{\e[0;33m%}'
    local BLUE=$'%{\e[0;34m%}'
    local LIGHT_BLUE=$'%{\e[1;34m%}'
    local PURPLE=$'%{\e[0;35m%}'
    local CYAN=$'%{\e[0;36m%}'
    local LIGHT_GRAY=$'%{\e[0;37m%}'
    local BOLD=$'%{\e[0;1m%}'
    local RESET_COLOR=$'%{\e[0m%}'

    # Настройка цветов промпта
    local prompt_color=$'%{\e[32m%}'
    local info_color=$'%{\e[1;34m%}'
    local prompt_symbol='@'
    
    # Проверка root пользователя
    if [ "$EUID" -eq 0 ]; then
        prompt_color=$'%{\e[94m%}'
        info_color=$'%{\e[1;31m%}'
        prompt_symbol='💀'
    fi

    # Формирование промпта для zsh с информацией об оболочке
    PROMPT="${prompt_color}┌─ᶻˢʰ─"
    PROMPT+="${VIRTUAL_ENV:+(${BOLD}$(basename $VIRTUAL_ENV)${prompt_color})}"
    PROMPT+="${CYAN}$(check_chroot)${prompt_color}"
    PROMPT+="[${info_color}%n${prompt_symbol}%m${prompt_color}]"
    PROMPT+="[${RESET_COLOR}%~${prompt_color}]"
    PROMPT+="${YELLOW}$(parse_git_branch)${LIGHT_GRAY}"
    PROMPT+=$'\n'
    PROMPT+="${prompt_color}└─${info_color}%(#.☠.$) ${RESET_COLOR}"
}


# Добавляем функцию precmd для автоматического обновления промпта
precmd() {
    prompt_builder
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
