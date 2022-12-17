#!/usr/bin/env bash

LC_ALL=C
export LC_ALL

version="mytest script v0.1"

usage="Usage: $0 [OPTION]...
This is simple usage description

Options:

  -r          Print normal output and revert output
  -f          Print output inside /tmp/myscriptoutput
  --help      Display this help and exit
  --version   Output version information and exit

Report bugs to mikhail.mladshev@gmail.com"

if test $# -eq 0; then
  # echo >&2 "$0: invalid number of operands; try \`$0 --help' for help"
  seq 10 | shuf | paste - -s -d ' '
  exit 1
fi
rm -f /tmp/myscriptoutput

file=0
rev=0
res=0

for arg
do
  case "$arg" in
  --help)      printf '%s\n' "$usage"   || exit 1; exit;;
  --version)   printf '%s\n' "$version" || exit 1; exit;;
  -r)           rev=1 ;;
  -f)           file=1 ;;
  *)           echo "No such argument, use --help"; exit;;
  esac
done

for i do
  if test $rev -eq 1; then
    res=$(seq 10 | shuf | paste - -s -d ' ')
    if test $file -eq 1; then
      echo $res > /tmp/myscriptoutput
      echo $res | rev >> /tmp/myscriptoutput
    else
      echo $res 
      echo $res | rev
    fi
  elif test $file -eq 1; then
    seq 10 | shuf | paste - -s -d ' ' > /tmp/myscriptoutput
  fi
done
exit