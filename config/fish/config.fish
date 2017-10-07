set -U EDITOR vim

if [ -f $HOME/.config/fish/functions/solarized.fish ]
	source $HOME/.config/fish/functions/solarized.fish    
end

set fish_greeting
# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_showcolorhints 'yes'
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_color_branch magenta
set __fish_git_prompt_color_upstream green
set __fish_git_prompt_color_flags blue

# Status Chars
set __fish_git_prompt_char_cleanstate '✔'
set __fish_git_prompt_char_dirtystate '*'
#set __fish_git_prompt_char_dirtystate '✚'
set __fish_git_prompt_char_invalidstate '#'
#set __fish_git_prompt_char_invalidstate '✖'
set __fish_git_prompt_char_stagedstate '+'
#set __fish_git_prompt_char_stagedstate '●'
#set __fish_git_prompt_char_stashstate '$'
#set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_char_stateseparator '|'
set __fish_git_prompt_char_untrackedfiles '%'
#set __fish_git_prompt_char_untrackedfiles '…'
set __fish_git_prompt_char_upstream_ahead '>'
#set __fish_git_prompt_char_upstream_ahead ''↑'
set __fish_git_prompt_char_upstream_behind '<'
#set __fish_git_prompt_char_upstream_behind '↓'
set __fish_git_prompt_char_upstream_diverged '<>'
set __fish_git_prompt_char_upstream_equal '='
set __fish_git_prompt_char_upstream_prefix ''


function fish_error
	set error_code $status
	if [ $error_code -gt 0 ];
		set fish_color_status red
        #set_color $fish_color_status --bold
		set_color $fish_color_status
		printf [$error_code]
end
end

function fish_prompt
	fish_error # If last command returned an error, print it.
	set_color normal # Only necessary because the bold from fish_error wont go away otherwise...

	echo #space between commands
	if [ (whoami) = 'root' ]
		set_color normal 
		printf (date "+$c2%H$c0:$c2%M$c0:$c2%S ")
		set_color red
		printf '%s' (whoami)
		set_color normal
		printf '@'

		set_color red
		printf '%s' (hostname|cut -d . -f 1)
		set_color normal
		printf ' in '

		set_color $fish_color_cwd
		printf '%s %s' (prompt_pwd) (__fish_git_prompt)
		#$__git_cb
		set_color normal

		# Line 2
		echo
		if test $VIRTUAL_ENV
			printf "(%s)" (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
  end
  printf '# '

  set_color normal

   else
	   set_color normal 
	   printf (date "+$c2%H$c0:$c2%M$c0:$c2%S ")
	   set_color yellow
	   printf '%s' (whoami)
	   set_color normal
	   printf '@'

	   set_color $fish_color_hostname
	   printf '%s' (hostname|cut -d . -f 1)
	   set_color normal
	   printf ' in '

	   set_color $fish_color_cwd
	   printf '%s' (prompt_pwd) 
	   set_color normal	  
	   printf '%s' (__fish_git_prompt)
	   #$__git_cb
	   set_color normal

	   # Line 2
	   echo
	   if test $VIRTUAL_ENV
		   printf "(%s)" (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
  end
  printf '$ '

  set_color normal
   end
end
set -x SVN_EDITOR vim

set -x GOPATH $HOME/Code/Other_Projects/go-code

# Load aliases
if [ -f $HOME/.config/fish/aliases.fish ]
	source $HOME/.config/fish/aliases.fish    
end

# Load nice colors
if [ -f $HOME/.config/fish/functions/dircolors.fish ]
	source $HOME/.config/fish/functions/dircolors.fish
end
# TLDR color defines
export TLDR_COLOR_BLANK="white"
export TLDR_COLOR_NAME="cyan"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="green"
export TLDR_COLOR_COMMAND="red"
export TLDR_COLOR_PARAMETER="white"
export TLDR_CACHE_ENABLED=1
export TLDR_CACHE_MAX_AGE=720

export SHELL=/usr/bin/fish

set -gx PATH $PATH $HOME/.local/bin/
set -gx PATH $PATH $HOME/Projects/uPy/esp-open-sdk/xtensa-lx106-elf/bin/
