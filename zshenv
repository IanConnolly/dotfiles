rtags() {
    ctags --languages=ruby . `bundle show --paths`
}

function cleararc {
     arc list | grep Accepted | cut -c 3- | awk '{ print $2  }' | sed 's/.$//' | while read rev; do arc close-revision $rev; done
}

gitme() {
    if [ "$1" != "" ]
    then
        git log --author="$1" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2  } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc  }' -
    else
        git log --author="Ian Connolly" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2  } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc  }' -
    fi
}

dir() {
  fd
}

fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

edit() {
  fe
}

fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

fgr() {
    local file
    file=$(grep --line-buffered --color=never -r "" * | fzf | sed 's/:.*$//')
    [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

branch() {
  fbr
}

fbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf +s +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}
