_CF_COMMAND=1
_COMPLETION_LOCATION="$HOME/workspace/cf_completion"

_echo_array() {
  echo "Array items and indexes:"
  local array=( "$@" )
  for index in ${!array[*]}
  do
    printf "%4d: %s\n" $index ${array[$index]}
  done
}

_cf_completion() {
  # echo -e "\nComp CWord: ${COMP_CWORD}"
  # echo -e "\nWORD Count: ${#COMP_WORDS[*]}"
  # to_be_echoed=$COMP_WORDS
  # _echo_array "${COMP_WORDS[@]}"

  if [ $COMP_CWORD -eq $_CF_COMMAND ]; then
    COMMAND_LIST=`ruby ${_COMPLETION_LOCATION}/list_commands.rb ${COMP_WORDS[$COMP_CWORD]}`
    COMPREPLY=( ${COMMAND_LIST} )
  else
    COMPREPLY=()
  fi

  return 0
}

complete -F _cf_completion cf
