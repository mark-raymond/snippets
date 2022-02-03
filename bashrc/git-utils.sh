REPOS_ROOT='/g'
DefaultUser='red-gate'

clean-git-branches() {
  git branch | grep -v '*' | xargs -r git branch -d 2>&1 | grep -v "^error: The branch '[^']\+' is not fully merged\.$" | grep -v "^If you are sure you want to delete it, run 'git branch -D [^']\+'\.$" || true
}

clone() {
  if [ $# -eq 1 ]; then
    IFS=/ read -a split <<<"$1"
    length=${#split[@]}
    if [ $length -eq 2 ]; then
      GitHubUser="${split[0]}"
      GitHubRepo="${split[1]}"
    elif [ $length -eq 1 ]; then
      GitHubUser="$DefaultUser"
	  GitHubRepo="${split[0]}"
    else
      echo 'Repo name cannot contain more than one forward slash!' >&2
	  return 1
    fi
  else
    echo 'Wrong number of arguments. Usage:' >&2
    echo '  clone REPO' >&2
    echo '  clone USER/REPO' >&2
    return 1
  fi

  mkdir -p "$REPOS_ROOT/$GitHubUser"
  cd "$REPOS_ROOT/$GitHubUser"
  test -d "$GitHubRepo" || git clone "git@github.com:$GitHubUser/$GitHubRepo.git" || return $?
  cd "$GitHubRepo"
}

get-ready() {
  if [ $# -gt 1 ]; then
    echo 'Too many arguments! Usage:' >&2
    echo '  get-ready                Fetches all changes, checks out origin/HEAD, and clears out old branches' >&2
    echo "  get-ready REPO           Ensures $DefaultUser/REPO is cloned, and then runs get-ready on it" >&2
    echo '  get-ready USER/REPO      Ensures USER/REPO is cloned, and then runs get-ready on it' >&2
    return 1
  elif [ $# -eq 1 ]; then
    clone "$1"
  fi

  if [[ $(git status --porcelain) ]]; then
    echo 'There are uncommitted changes, exiting.'
    return 1
  fi

  git fetch --prune || return $?
  git checkout origin/HEAD || return $?
  clean-git-branches || return $?
}
