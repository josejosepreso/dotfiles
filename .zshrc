autoload -U colors && colors	
PS1="%B%{$fg[red]%}%n% @%M %{$fg[blue]%}%~ $ %b"
#
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="/home/jose/.cache/zsh/history"
setopt inc_append_history
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

#
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
#
#
#
alias \
	cp="cp -iv" \
	mv="mv -iv" \
	bc="bc -ql" \
	rsync="rsync -vrPlu" \
	mkd="mkdir -pv" \
alias mp3='yt-dlp -x --audio-format mp3 --audio-quality 0'
# alias ls='ls -la --color=always'
alias ls='eza -al --color=always --group-directories-first'
alias grep='grep --color=auto'
alias cdf='cd "$(find . -type d | fzf)"'
alias myyt='java -jar Myyt.jar'
alias screenrec='ffmpeg -video_size 1366x768 -framerate 25 -f x11grab -i :0.0 output.mkv'
alias shizuku='adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh'

export VISUAL='nvim'
export EDITOR='nvim'
export PATH=$PATH:/home/jose/scripts
export PATH=$PATH:/home/jose/.local/bin
export PATH=$PATH:/home/jose/.config/emacs/bin
#
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export WINIT_X11_SCALE_FACTOR=1
#

fastfetch
# ufetch

export PATH="/home/jose/.pixi/bin:$PATH"
