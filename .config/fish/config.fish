if status is-interactive
    # Commands to run in interactive sessions can go here

    #sets the shell greeting
    set -U fishell_greeting

    set EDITOR 'emacs'
    set VISUAL 'emacs'

    alias l='exa -lahF --color=always --icons --sort=size --group-directories-first'
    alias ls='exa -lhF --color=always --icons --sort=size --group-directories-first'
    alias lst='exa -lahFT --color=always --icons --sort=size --group-directories-first'

    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'

    alias ssn='sudo shutdown now'
    alias sr='sudo reboot'

    alias df='df -h'
    alias du='du -h'

    alias sys='sudo systemctl'
    
    alias sinstall 'sudo dnf install'
    alias update 'sudo dnf -y update'

    starship init fish | source

    neofetch

    fish_add_path /home/christian/bin
    fish_add_path /home/christian/.screenlayout
    fish_add_path /home/christian/.bashell.d
    fish_add_path /home/christian/.emacs.d/bin

end
