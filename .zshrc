###############
#### ZPLUG ####
###############
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "plugins/z", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

###############
## ENV VARS ###
###############
export TERM="xterm-256color"
export PATH=$PATH:$HOME/bin

###############
### HISTORY ###
###############
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt appendhistory
setopt extended_glob

###############
#### ZPLUG ####
###############
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load #--verbose

alias re='source ~/.zshrc'
alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gck='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gl='git log'
alias gp='git push'
alias gpl='git pull'
alias gdc='git diff --cached'
alias dc='docker-compose'
alias zsh='code ~/.zshrc'
alias copex='gh copilot explain'
alias copsug='gh copilot suggest'
alias update='ncu -u;'
alias build='npm run build'
alias dev='npm run dev'
alias ni='npm install'
alias fixperms='sudo chown -R $USER:$USER . && sudo chmod -R 777 .'
alias hosts='code /etc/hosts'

# search string
function search() {
  grep -RinF $1 .
}

# search conflicts
function conflicts() {
  grep -RinF "======" .
  grep -RinF "<<<<<<" .
  grep -RinF ">>>>>>" .
}

eval "$(starship init zsh)"