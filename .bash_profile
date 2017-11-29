###export PATH=/usr/local/git/bin:$PATH
export GREP_OPTIONS='--color=auto --exclude=*.class --exclude-dir=target'
export GIT_EDITOR=vim
export PS1="[\[\033[00m\]\u@\h\[\033[32m\] \W \[\033[31m\]\$(parse_git_repo)-\$(parse_git_branch)\[\033[00m\]]$\[\033[00m\] "
export PATH=/usr/local/bin:$PATH

alias ll='ls -al'
alias s='git status'
# ignore whitespace: alias d='git diff -w HEAD'
alias d='git diff HEAD'
alias comp='python ~/py_test_compile.py'

function get() {
    git log -"$1" | sed "s/commit /https:\/\/github\.com\/.*\/$(parse_git_branch)\/commit\//" | sed 's/\(.*commit.*\)$/\1/'
}

# setup a virtualenv
function ve() {                                                                 
    virtualenv "$1"                                                             
    source "$1/bin/activate"                                                    
}

# pbcopy is osx specific
function gh() {
    git log -"$1" | grep 'commit' | sed "s/commit /https:\/\/github\.com\/.*\/$(parse_git_repo)\/commit\//" | sed 's/\(.*commit.*\)$/\1\?w=1/' | pbcopy
    git log -"$1" | sed "s/commit /https:\/\/github\.com\/.*\/$(parse_git_repo)\/commit\//" | sed 's/\(.*commit.*\)$/\1\?w=1/'
}

parse_git_repo() {
    git config --get remote.origin.url | sed 's/https:\/\/github.com\/.*\/\(.*\)\.git/\1/'
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function scp_machine {
    rsync -rlpt -e "ssh -A bastione1 ssh -A" --delete $1 machine:$2
}

function dc() {
    sudo docker exec -i -t $1 /bin/bash
}

