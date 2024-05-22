# Enable colors and change prompt:
PS1="[%n@%M %~]\$ "

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
	rm="rm -vI" \
	bc="bc -ql" \
	rsync="rsync -vrPlu" \
	mkd="mkdir -pv" \
alias pkglist='pacman -Qqe | grep -v base'
alias mp3='yt-dlp -x --audio-format mp3 --audio-quality 0 $@'
# alias ls='ls -al --color=always'
alias ls='ls --color=always -a'
alias grep='grep --color=auto'

export EDITOR='vim'
export PATH=$PATH:/home/jose/scripts
export PATH=$PATH:/home/jose/.local/bin

fastfetch --cpu-temp
