rtags() {
    ctags --languages=ruby,html,javascript . `bundle show --paths`
}

gitme() {
    if [ "$1" != "" ]
    then
        git log --author="$1" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2  } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc  }' -
    else
        git log --author="Ian Connolly" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2  } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc  }' -
    fi
}
