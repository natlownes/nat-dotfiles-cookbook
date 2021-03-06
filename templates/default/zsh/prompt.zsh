 setopt No_X_Trace;
 setopt No_Verbose;

 if ! type redisplay 2>/dev/null 1>/dev/null; then
    declare -x PS1
    declare -x PS2;
    declare -x PS3;
    declare -x PS4;

    setopt Prompt_Percent
    setopt No_Prompt_CR

    PS1="%{[43m%}%~ %{[41m%} $(uname) %{[45m%} %n@{[42m%} %D{b H:S} %{[46m%} standart %{[m%}
 >";
    PS2="%_>";
    PS3="?#";
    PS4="+i>";

    bindkey -v

    zmodload zsh/parameter &>/dev/null

    function redisplay()
	{
	builtin zle .redisplay
	( true ; show_mode "INSERT") &!
	}
    zle -N redisplay

    function redisplay2()
	{
	builtin zle .redisplay
	(true ; show_mode "NORMAL") &!
	}
    zle -N redisplay2

    function screenclear ()
	{
	echo -n "\033[2J\033[400H"
	builtin zle .redisplay
	(true ; show_mode "INSERT") &!
	}
    zle -N screenclear

    function screenclearx ()
	{
	repeat 2 print 
	local MYLINE="$LBUFFER$RBUFFER"
	highlight $MYLINE
	repeat 4 print 
	builtin zle redisplay
	}
    zle -N screenclearx

    function show_mode()
	{
	local COL
	local x
	COL=COLUMNS-3
	COL=COL-$#1
	x=$(echo $PREBUFFER | wc -l )
	x=x+1
	echo -n "7[$x;A[0;G"
	echo -n ""
	echo -n "[0;37;44m--$1--[0m"
	echo -n "8"
	}

    ###	  vi-add-eol (unbound) (A) (unbound)
    ###		 Move  to the end of the line and enter insert mode.

    function vi-add-eol()
	{
	show_mode "INSERT"
	builtin zle .vi-add-eol
	}
    zle -N vi-add-eol

    ###	  vi-add-next (unbound) (a) (unbound)
    ###		 Enter insert mode after the  current  cursor  posi­
    ###		 tion, without changing lines.

    function vi-add-next()
	{
	show_mode "INSERT"
	builtin zle .vi-add-next
	# OLDLBUFFER=$LBUFFER
	# OLDRBUFFER=$RBUFFER
	# NNUMERIC=$NUMERIC
	# bindkey -M viins "" vi-cmd-mode-a
	}
    zle -N vi-add-next

    ###	  vi-change (unbound) (c) (unbound)
    ###		 Read a movement command from the keyboard, and kill
    ###		 from  the  cursor  position  to the endpoint of the
    ###		 movement.  Then enter insert mode.  If the  command
    ###		 is vi-change, change the current line.

    function vi-change()
	{
	show_mode "INSERT"
	builtin zle .vi-change
	}
    zle -N vi-change

    ###	  vi-change-eol (unbound) (C) (unbound)
    ###		 Kill  to the end of the line and enter insert mode.

    function vi-change-eol()
	{
	show_mode "INSERT"
	builtin zle .vi-change-eol
	}
    zle -N vi-change-eol

    ###	  vi-change-whole-line (unbound) (S) (unbound)
    ###		 Kill the current line and enter insert mode.

    function vi-change-whole-line()
	{
	show_mode "INSERT"
	builtin zle .vi-change-whole-line
	}
    zle -N vi-change-whole-line

    ###	  vi-insert (unbound) (i) (unbound)
    ###		 Enter insert mode.

    function vi-insert()
	{
	show_mode "INSERT"
	builtin zle .vi-insert
	}
    zle -N vi-insert

    ###	  vi-insert-bol (unbound) (I) (unbound)
    ###		 Move to the first non-blank character on  the	line
    ###		 and enter insert mode.

    function vi-insert-bol()
	{
	show_mode "INSERT"
	builtin zle .vi-insert-bol
	}
    zle -N vi-insert-bol

    ###	  vi-open-line-above (unbound) (O) (unbound)
    ###		 Open a line above the cursor and enter insert mode.

    function vi-open-line-above()
	{
	show_mode "INSERT"
	builtin zle .vi-open-line-above
	}
    zle -N vi-open-line-above

    ###	  vi-open-line-below (unbound) (o) (unbound)
    ###		 Open a line below the cursor and enter insert mode.

    function function vi-open-line-below()
	{
	show_mode "INSERT"
	builtin zle .vi-open-line-below
	}
    zle -N vi-open-line-below

    ###	  vi-substitute (unbound) (s) (unbound)
    ###		 Substitute the next character(s).

    function vi-substitute()
	{
	show_mode "INSERT"
	builtin zle .vi-substitute
	}
    zle -N vi-substitute

    ###	  vi-replace (unbound) (R) (unbound)
    ###		 Enter overwrite mode.

    function vi-replace()
	{
	show_mode "REPLACE"
	builtin zle .vi-replace
	}
    zle -N vi-replace

    ###	  vi-cmd-mode (^X^V) (unbound) (^[)
    ###		 Enter	command  mode;	that  is, select the `vicmd'
    ###		 keymap.  Yes, this is bound  by  default  in  emacs
    ###		 mode.

    function vi-cmd-mode()
	{
	show_mode "NORMAL"
	builtin zle .vi-cmd-mode
	}
    zle -N vi-cmd-mode

    ###	  vi-oper-swap-case
    ###		 Read a movement command from the keyboard, and swap
    ###		 the case of all characters from the cursor position
    ###		 to the endpoint of the movement.  If  the  movement
    ###		 command  is vi-oper-swap-case, swap the case of all
    ###		 characters on the current line.
    ###

    bindkey -M vicmd "A"	vi-add-eol
    bindkey -M vicmd "C"	vi-change-eol
    bindkey -M vicmd "I"	vi-insert-bol
    bindkey -M vicmd "O"	vi-open-line-above
    bindkey -M vicmd "R"	vi-replace
    bindkey -M vicmd "S"	vi-change-whole-line
    bindkey -M vicmd "\eO2R"	vi-rev-repeat-search
    bindkey -M vicmd "\eOA"     up-line-or-history
    bindkey -M vicmd "\eOB"     down-line-or-history
    bindkey -M vicmd "\eOC"     vi-forward-char
    bindkey -M vicmd "\eOD"     vi-backward-char
    bindkey -M vicmd "\eOP"	run-help
    bindkey -M vicmd "\eOR"	vi-repeat-search
    bindkey -M vicmd "\e[1~"    vi-first-non-blank
    bindkey -M vicmd "\e[2~"    vi-insert
    bindkey -M vicmd "\e[3~"    vi-delete-char
    bindkey -M vicmd "\e[4~"    vi-end-of-line
    bindkey -M vicmd "\e[5~"    history-search-backward
    bindkey -M vicmd "\e[6~"    history-search-forward
    bindkey -M vicmd "\e[A"     up-line-or-history
    bindkey -M vicmd "\e[B"     down-line-or-history
    bindkey -M vicmd "\e[C"     vi-forward-char
    bindkey -M vicmd "\e[D"     vi-backward-char
    bindkey -M vicmd "\e[F"     vi-end-of-line
    bindkey -M vicmd "\e[H"     vi-first-non-blank
    bindkey -M vicmd "^?"	backward-delete-char
    bindkey -M vicmd "^A"	beginning-of-line
    bindkey -M vicmd "^B"	history-search-backward
    bindkey -M vicmd "^E"	end-of-line
    bindkey -M vicmd "^F"	history-search-forward
    bindkey -M vicmd "^H"	backward-delete-char
    bindkey -M vicmd "^R"	redo
    bindkey -M vicmd "^X^R"     redisplay2
    bindkey -M vicmd "a"	vi-add-next
    bindkey -M vicmd "c"	vi-change
    bindkey -M vicmd "ga"	what-cursor-position
    bindkey -M vicmd "g~"	vi-oper-swap-case
    bindkey -M vicmd "i"	vi-insert
    bindkey -M vicmd "o"	vi-open-line-below
    bindkey -M vicmd "s"	vi-substitute
    bindkey -M vicmd "u"	undo

    bindkey -M viins ""	screenclear
    bindkey -M viins ""	vi-cmd-mode
    bindkey -M viins "\eO2R"	vi-rev-repeat-search
    bindkey -M viins "\eOA"     up-line-or-history
    bindkey -M viins "\eOB"     down-line-or-history
    bindkey -M viins "\eOC"     vi-forward-char
    bindkey -M viins "\eOD"     vi-backward-char
    bindkey -M viins "\eOP"	run-help
    bindkey -M viins "\eOR"	vi-repeat-search
    bindkey -M viins "\e[1~"	vi-first-non-blank
    bindkey -M viins "\e[2~"    vi-insert
    bindkey -M viins "\e[3~"    vi-delete-char
    bindkey -M viins "\e[4~"    vi-end-of-line
    bindkey -M viins "\e[5~"    history-search-backward
    bindkey -M viins "\e[6~"    history-search-forward
    bindkey -M viins "\e[A"     up-line-or-history
    bindkey -M viins "\e[B"     down-line-or-history
    bindkey -M viins "\e[C"     vi-forward-char
    bindkey -M viins "\e[D"     vi-backward-char
    bindkey -M viins "\e[F"     vi-end-of-line
    bindkey -M viins "\e[H"     vi-first-non-blank
    bindkey -M viins "^?"	backward-delete-char
    bindkey -M viins "^A"	beginning-of-line
    bindkey -M viins "^E"	end-of-line
    bindkey -M viins "^H"	backward-delete-char
    bindkey -M viins "^X^R"	redisplay
    bindkey -M viins "^Xl"	screenclearx

    printf "\e[42m%-30.30s : \e[43m %-40.40s \e[m\n" "$(basename ${0})" "Color prompt set."
 fi;