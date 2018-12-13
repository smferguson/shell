#export PATH=/usr/local/git/bin:$PATH
export GREP_OPTIONS='--color=auto --exclude=*.class --exclude-dir=target'
export GIT_EDITOR=vim
export PS1="[\[\033[00m\]\u@\h\[\033[32m\] \W \[\033[31m\]\$(parse_git_repo)-\$(parse_git_branch)\[\033[00m\]]$\[\033[00m\] "
export PATH=/usr/local/bin:$PATH

alias ll='ls -al'
alias dev='cd ~/dev'

alias s='git status'
# ignore whitespace: alias d='git diff -w HEAD'
alias d='git diff HEAD'
alias catchup='git pull --rebase upstream master'

alias comp='python ~/py_test_compile.py'


# setup a virtualenv
function ve() {                                                                 
    virtualenv "$1"                                                             
    source "$1/bin/activate"                                                    
}

# pbcopy is osx specific
function lc() {
    git log -"1" | grep 'commit' | sed "s/commit /https:\/\/github\.com\/$(parse_git_org)\/$(parse_git_repo)\/commit\//" | sed 's/\(.*commit.*\)$/\1\?w=1/' | pbcopy
    git log -"1" | sed "s/commit /https:\/\/github\.com\/$(parse_git_org)\/$(parse_git_repo)\/commit\//" | sed 's/\(.*commit.*\)$/\1\?w=1/'
}

parse_git_org() {
    git config --get remote.origin.url | sed 's/https:\/\/github.com\/\(.*\)\/.*\.git/\1/'
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
    docker exec -i -t $1 /bin/bash
}

function ds() {
    docker stop $1
}

alias python='python3'

# access & port forwarding
alias bastion='ssh -i ~/.ssh/dev-main -At ec2-user@<IP> -p 22'
alias dev_airflow='ssh -nNT -L 8888:airflow.main.dev.causemo.com:8080 -i ~/.ssh/dev-main ec2-user@<IP> -p 22'
alias dev_airflowdb='ssh -nNT -L 5439:main-airflow.cwuzk8uemazj.us-east-1.rds.amazonaws.com:5439 -i ~/.ssh/dev-main ec2-user@<IP> -p 22'
alias dev_redshift='ssh -nNT -L 5439:main-redshift-cluster.cgmqqwgj9rmo.us-east-1.redshift.amazonaws.com:5439 -i ~/.ssh/dev-main ec2-user@<IP> -p 22'

