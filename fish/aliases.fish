# Global aliases
alias c 'clear'     # Clear screen
#alias - 'cd -'      # Last folder
alias sl 'ls'
alias md 'mkdir'    # Make directory
alias bc 'bc -ql'   # No welcome message, improved functions
alias iftop 'iftop -B'  # Measure in Bytes instead of Bits
alias ping 'ping -c3'   # Default to 3 attemps instead of unlimited
alias tmux 'tmux -2'    # Force 256 colors
alias :e 'vim'      # Launch vim with ":e"
alias :q 'exit'     # exit with vim command
alias crontab 'crontab -i'  # No accidental removals
alias chmox 'chmod +x'
alias mount 'mount | column -t'

function please
    eval sudo $history[1]
end

function bash
    /usr/bin/env bash --login
end

function su
	sudo /bin/su --shell=/usr/bin/fish
end

function vimall
    set FILES ./*
    vim -p $FILES    
end

function mk
    mkdir $argv; and cd $argv
end

function cs
    cd $argv; and ls
end
