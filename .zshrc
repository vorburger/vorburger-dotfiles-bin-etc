# Path to your oh-my-zsh installation.
  export ZSH=/home/vorburger/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git repo zsh-completions history-substring-search kubectl command-not-found autojump history dircycle dirhistory dirpersist last-working-dir chucknorris mvn gradle ant httpie docker bower web-search colored-man-pages copydir)
#  npm

# User configuration

HISTFILE=~/.zsh_history-$$
HISTSIZE=256

export EDITOR=nano

# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
# export JAVA_HOME=/home/vorburger/bin/jdk8
# export ANT_HOME=/home/vorburger/bin/ant_athome
# export M2_HOME=/home/vorburger/bin/apache-maven-3.3.9
export M2_HOME=/home/vorburger/bin/apache-maven-3.5.2
export GRADLE_HOME=/home/vorburger/bin/gradle-3.2.1
# export GOROOT=/home/vorburger/bin/golang
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH=$PATH:$JAVA_HOME/bin:$ANT_HOME/bin:$M2_HOME/bin:$GRADLE_HOME/bin:$NPM_PACKAGES/bin:/home/vorburger/.cargo/bin

# only suitable for single artifact JAR quick builds; not for full multi module project 
# export MAVEN_OPTS="-client -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xverify:none"
MAVEN_OPTS="-Xmx4096m -Xverify:none"

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

unsetopt correct_all
unsetopt correct


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias mvno='mvn -s ~/.m2/settings-odl.xml'
alias pssx='pss --ignore-dir=target --ignore-dir=target-ide'

alias gcmp='git checkout master && git pull'
alias mooci='mvn -s ~/.m2/settings-odl.xml -o clean install'
alias moci='mvn -s ~/.m2/settings-odl.xml clean install'

# https://dev.to/sarathsantoshdamaraju/git-aliases-that-could-be-helpful-5bdp
alias g!='git init' 
alias g.='git add .'
alias g.-file='git add'
alias gb='git branch'
alias gb-new='git checkout -b'
alias gblame='git blame'
alias gcl='git clone'
alias gc='git commit -m'
alias gcout='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gl='git log'
alias gph='git push'
alias gph-f='git push -f'
alias gpl='git pull'
alias gr='git remote'
alias gr-list='git remote -v'
alias gr-add='git remote add'
alias greset='git reset --hard'
alias grevert-head='git revert HEAD'
alias grevert='git revert'
alias gs='git status'
alias gsh='git stash'
alias gsh-a='git stash apply'
alias gsh-c='git stash clear'
alias gsh-d='git stash drop'
alias gsh-l='git stash list'
alias gsh-p='git stash pop'

# todo.txt
# inspired by https://github.com/fixlr/dotfiles/blob/master/todo.txt/aliases.zsh
TODO="/home/vorburger/bin/todo.txt-cli/todo.sh -d /home/vorburger/dev/todo.txt-vorburger/todo.cfg"
function t() { 
  if [ $# -eq 0 ]; then
    eval $TODO ls
  else
    eval $TODO $*
  fi
}

function te() {
  gedit /home/vorburger/dev/todo.txt-vorburger/todo.txt +$1
}

alias ted="gedit /home/vorburger/dev/todo.txt-vorburger/done.txt"

alias tad="$TODO add '(A)$*'"
alias taw="$TODO add '(B)$*'"
alias tam="$TODO add '(C)$*'"
alias taq="$TODO add '(D)$*'"
alias tax="$TODO add 'x $*'"

alias tld="t lsp A"
alias tlw="t lsp A-B"
alias tlm="t lsp C"
alias tlq="t lsp D"

alias tldw="t lsp A @work"
alias tlww="t lsp A-B @work"

alias td="$TODO do '$*'"

alias tm="todotxt-machine /home/vorburger/dev/todo.txt-vorburger/todo.txt /home/vorburger/dev/todo.txt-vorburger/done.txt"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/vorburger/.sdkman"
[[ -s "/home/vorburger/.sdkman/bin/sdkman-init.sh" ]] && source "/home/vorburger/.sdkman/bin/sdkman-init.sh"

# added by travis gem
[ -f /home/vorburger/.travis/travis.sh ] && source /home/vorburger/.travis/travis.sh

# source <(/home/vorburger/bin/oc completion zsh)
source <(/usr/bin/oc completion zsh)
