_bash_exec () {
  file="$1"
  code="$2"

  function_names="typeset -f | sed '/^{\s*\\\$/,/^}\s*\\\$/d' | sed 's/\s*[(][)]\s*\\\$//' | sort"
  variable_names="env | grep -v '^_|PIPESTATUS|COLUMNS|SHLVL\\\$' | sort"

  # Create temp files to catch the change of variables and functions
  functions_before=$(mktemp)
  functions_after=$(mktemp)
  variables_before=$(mktemp)
  variables_after=$(mktemp)

  before="$function_names > $functions_before; $variable_names > $variables_before"
  after="$function_names > $functions_after; $variable_names > $variables_after"

  eval "MANPATH="$MANPATH:" PATH="$PATH:" /usr/bin/env bash -c \"$before; . $file; $code $after\""

  # Separator used by read to store a single line into several variables
  IFS='='

  # Diff of the env in the format (+|-)=(?<VAR>.+)=(?<VALUE>.+)
  diffopts=(--old-line-format '-=%L' --new-line-format '+=%L' --unchanged-line-format)

  diff $diffopts '' $variables_before $variables_after | while read state var value
  do
    case $state$var
    in
      -PATH|-MANPATH)
        ;;
      +PATH|+MANPATH)
        # split by colons into an array
        value=(${(s.:.)value})
        # reverse array (because preprending will cause reversing again)
        value=(${(Oa)value})

        current=$(eval echo \$$var)
        current=(${(s.:.)current})

        # Sync dirs removed from the path
        for dir in $current
        do
          if [ "${value[(r)$dir]}" ]; then continue; fi;

          # DEBUG:
          # echo remove \"$dir\" from the \$$var

          current[$current[(i)$dir]]=()
        done

        # Sync dirs added to the path
        for dir in $value
        do
          if [ "${current[(r)$dir]}" ]; then continue; fi;

          # DEBUG:
          # echo prepend \"$dir\" to the \$$var

          current=($dir $current)
        done

        export $var=${(j.:.)current}
        ;;
      -*)
        # DEBUG:
        # echo unset $var \(old: \'$(eval echo \$$var)\'\)

        unset $var
        ;;
      +*)
        # DEBUG:
        # echo Set \$$var to \'$value\' \(old: \'$(eval echo \$$var)\'\)

        export $var=$value
        ;;
      *)
        echo "Source error! Invalid case '$state$var'" >&2
        ;;
    esac
  done

  diff $diffopts '' $functions_before $functions_after | while read state func
  do
    case $state$func
    in
      -*)
        # Do nothing if a function was removed
        ;;
      +*)
        # Create wrapper function
        eval "$func() { code=\"$func \$@;\"; _bash_exec $file \$code }"

        # DEBUG:
        # echo Create wrapper for $func from $file
        ;;
      *)
        echo "Source error! Invalid case '$func'" >&2
        ;;
    esac
  done

  unset IFS

  # Remove temporary files
  command rm $variables_before $variables_after $functions_before $functions_after >/dev/null
}

source_bash () {
  if [ $# = 0 ]
  then
    echo "Called with no arguments" >&2
    return 1
  fi

  for file in $@
  do
    _bash_exec $file
  done
}
