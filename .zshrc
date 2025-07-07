# Enable colors and change prompt:
# PS1="[%n@%M %~]\$ "
autoload -U colors && colors	# Load colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
PS1="%B%{$fg[red]%}%n% @%M %{$fg[blue]%}%~ $ %b"

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="/home/jose/.cache/zsh/history"
setopt inc_append_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';;      # 2: steady block
        viins|main) echo -ne '\e[6 q';; # 6: steady beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
 
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Aliases
# Verbosity and settings that you pretty much just always are going to want.
alias \
	cp="cp -iv" \
	mv="mv -iv" \
	bc="bc -ql" \
	rsync="rsync -vrPlu" \
	mkd="mkdir -pv" \
alias mp3='yt-dlp -x --audio-format mp3 --audio-quality 0'
alias pkglist='pacman -Qqe | grep -v base'
alias ls='eza -al --color=always --group-directories-first'
alias grep='grep --color=auto'
alias screenrec='ffmpeg -video_size 1366x768 -framerate 25 -f x11grab -i :0.0 output.mkv'
#alias screenrec='ffmpeg -video_size 1366x768 -framerate 25 -f x11grab -i :0.0 -f alsa -i hw:1 output.mkv'
alias campv='mpv av://v4l2:/dev/video0 --profile=low-latency --untimed'
alias cdf='cd "$(find . -type d | fzf)"'
alias dmk='pwd >> ~/.dmks'
alias livepdf='echo main.tex | entr -s "pdflatex main.tex; pkill -HUP mupdf"'
alias tf='terraform'
alias vim='nvim'

export VISUAL='nvim'
export EDITOR='nvim'
export PATH=$PATH:/home/jose/.cargo/bin
export PATH=$PATH:/home/jose/scripts
export PATH=$PATH:/home/jose/.local/bin
export PATH=$PATH:/home/jose/.config/bspwm
# export PATH=$PATH:/home/jose/Documents/Programming/E-S/
export WINIT_X11_SCALE_FACTOR=1

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# uwufetch
fastfetch
