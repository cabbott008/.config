### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths

### EXPORT ###
set fish_greeting # Supresses fish's intro message
set TERM kitty # Sets the terminal type
set EDITOR hx # $EDITOR use nvim in terminal
set VISUAL hx # $VISUAL use Emacs in GUI mode
set GIT_EDITOR hx

### "nvim" as manpager
set -x MANPAGER "hx +Man!"

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
    # fish_default_key_bindings
    fish_vi_key_bindings
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###
# Enable command history search via fzf.                                    
function reverse_history_search
    history | fzf --no-sort | read -l command
    if test $command
        commandline -rb $command
    end
end

function fish_user_key_bindings
    bind -M default / reverse_history_search
end

# bind \"\cr\" fzf-history-widget
# Functions needed for !! and !$
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end
# The bindings for !! and !$
if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end

### END OF FUNCTIONS ###

### ALIASES ###
# shutdown
alias sdn="shutdown now"

# Nvidia issue toggle auto-login and 15-monitor.conf

## RipDrag with FZF
alias cv='ripdrag $(fzf)'

## Screen Brightness
alias s9='echo 1000 | sudo tee /sys/class/backlight/gmux_backlight/brightness'
alias s8='echo 800 | sudo tee /sys/class/backlight/gmux_backlight/brightness'
alias s7='echo 620 | sudo tee /sys/class/backlight/gmux_backlight/brightness'
alias s6='echo 480 | sudo tee /sys/class/backlight/gmux_backlight/brightness'
alias s5='echo 360 | sudo tee /sys/class/backlight/gmux_backlight/brightness'
alias s4='echo 260 | sudo tee /sys/class/backlight/gmux_backlight/brightness'
alias s3='echo 150 | sudo tee /sys/class/backlight/gmux_backlight/brightness'
alias s2='echo 70 | sudo tee /sys/class/backlight/gmux_backlight/brightness'
alias s1='echo 35 | sudo tee /sys/class/backlight/gmux_backlight/brightness'
alias s0='echo 10 | sudo tee /sys/class/backlight/gmux_backlight/brightness'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim and emacs
alias vim='nvim'

# Changing "ls" to "exa"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first' # all files and dirs
alias ll='eza -l --color=always --group-directories-first' # long format
alias lt='eza -aT --color=always --group-directories-first --level=3' # tree listing
alias tree='tree -C --dirsfirst' #Colorized tree with Directories first
alias l.='eza -a | grep -E "^\."'

# # pacman and yay
# alias pacsyu='sudo pacman -Syu' # update only standard pkgs
# alias pacsyyu='sudo pacman -Syyu' # Refresh pkglist & update standard pkgs
# alias yaysua='yay -Sua --noconfirm' # update only AUR pkgs (yay)
# alias yaysyu='yay -Syu --noconfirm' # update standard pkgs and AUR pkgs (yay)
# alias parsua='paru -Sua --noconfirm' # update only AUR pkgs (paru)
# alias parsyu='paru -Syu --noconfirm' # update standard pkgs and AUR pkgs (paru)
# alias unlock='sudo rm /var/lib/pacman/db.lck' # remove pacman lock
# alias cleanup='sudo pacman -Rns (pacman -Qtdq)' # remove orphaned packages### FZF
# # Pacman
# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --exact +s'
# alias pacman_install="sudo pacman -S \$(pacman -Sl|awk '{print \$2}'|fzf -m)"
# alias pacman_uninstall="sudo pacman -Rcs \$(pacman -Q|awk '{print \$1}'|fzf -m)"
# alias pacman_update='sudo pacman -Syyu'
# # Yay
# alias paru_install="paru -S \$(paru -Sl|awk '{print \$2}'|fzf -m)"
# alias paru_uninstall="paru -Rcs \$(paru -Q|awk '{print \$1}'|fzf -m)"

# # get fastest mirrors
# alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
# alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
# alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
# alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

alias pbcopy='xsel --input --clipboard'
alias pbpaste='xsel --output --clipboard'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h' # human-readable sizes
alias free='free -m' # show sizes in MB
# alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
# alias vifm='./.config/vifm/scripts/vifmrun'
alias v='vifm'
# alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
# alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin --rebase'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# send preceding command output to hosting link
alias 0x0="curl -F 'file=@-' 0x0.st"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Play audio files in current dir by type
# alias playwav='deadbeef *.wav'
# alias playogg='deadbeef *.ogg'
# alias playmp3='deadbeef *.mp3'

# Play video files in current dir by type
alias playavi='vlc *.avi'
alias playmov='vlc *.mov'
alias playmp4='vlc *.mp4'

# yt-dlp
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "

# switch between shells
# I do not recommend switching default SHELL from bash.
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# termbin
alias tb="nc termbin.com 9999"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Unlock LBRY tips
alias tips="lbrynet txo spend --type=support --is_not_my_input --blocking"

# Mocp must be launched with bash instead of Fish!
alias mocp="bash -c mocp"

#Start X at login (handled in bash before fish is started)
# if status is-interactive
#     if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
#         exec startx -- -keeptty
#     end
# end
