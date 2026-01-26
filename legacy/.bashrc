export LANG=en_US.UTF-8
export MANPATH=/usr/share/man/ru:/usr/share/man:/usr/local/share/man
#export LANGUAGE=ru_RU:en_US
#export LC_MESSAGES=ru_RU.UTF-8
export MANOPT='-L ru_RU.UTF-8:en_US.UTF-8'

# Переменные окружения для текстового редактора в терминале
# Переменные окружения для текстового редактора в терминале
export GIT_EDITOR=$(command -v nvim || command -v vim || command -v mirco || command -v nano || command -v vi)
export EDITOR=$(command -v nvim || command -v vim || command -v mirco || command -v nano || command -v vi)
#export EDITOR=$(command -v micro || command -v nano || command -v nvim || command -v vim || command -v vi)
export VISUAL=$(command -v nvim || command -v vim || command -v mirco || command -v nano || command -v vi)
export SUDO_EDITOR=$(command -v nvim || command -v vim || command -v mirco || command -v nano || command -v vi)

# Настройки для less
export LESS="-R -M --shift 5"
export LESSCHARSET=utf-8

# Настройки для man
export MANPAGER="less -R"

# аллиас для sudo-rs
export SUDO_RS_ENABLED=1

if [[ "$SUDO_RS_ENABLED" == 1 ]]; then
  sudo() { command sudo-rs "$@"; }
fi


#source ~/.config/user-dirs.dirs

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

function proml {
    [ -f /etc/arch-chroot ] && ARCH_CHROOT="chroot" || ARCH_CHROOT=""
    local         RED="\[\033[0;31m\]"
    local   LIGHT_RED="\[\033[1;31m\]"

    local       GREEN="\[\033[0;32m\]"
    local LIGHT_GREEN="\[\033[1;32m\]"

    local      YELLOW="\[\033[0;33m\]"

    local        BLUE="\[\033[0;34m\]"
    local  LIGHT_BLUE="\[\033[1;34m\]"

    local  PURPLE="\[\033[0;35m\]"
    local  CYAN="\[\033[0;36m\]"

    local  LIGHT_GRAY="\[\033[0;37m\]"
    local  BOLD="\[\033[0;1m\]"

    local RESET_COLOR="\[\033[0m\]"
    case $TERM in
        xterm*)
        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
        *)
        TITLEBAR=""
        ;;
    esac

    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=@
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
        prompt_color='\[\033[;94m\]'
        info_color='\[\033[1;31m\]'
         #Skull emoji for root terminal
        prompt_symbol=💀
    fi


PS1="$prompt_color"
PS1+="┌ᵇᵃˢʰ─${ARCH_CHROOT:+($ARCH_CHROOT)──}"
PS1+="${VIRTUAL_ENV:+($BOLD$(basename $VIRTUAL_ENV)${prompt_color})}"
PS1+="[${info_color}\u${prompt_symbol}\h${prompt_color}]"
PS1+="["
PS1+="$BOLD\w"
PS1+="$prompt_color]"
PS1+="$YELLOW\$(parse_git_branch)$LIGHT_GRAY" #отображение ветки git
PS1+="\n"
PS1+="$prompt_color"
PS1+="└─"
PS1+="$info_color"
PS1+='$(if [ "$EUID" -eq 0 ]; then echo "#"; else echo "$"; fi)'
PS1+="\[\033[0m\] "

#PS2='> '
#PS4='+ '
}

proml
