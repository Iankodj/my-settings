export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# Display git branch in terminals
parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF='%f'
COLOR_USR='%F{243}'
COLOR_DIR='%F{76}'
COLOR_GIT='%F{39}'
NEWLINE=$'\n'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE}$ '

# Check for new GIT version
parse_new_git_version() {
    brew info git 2> /dev/null | sed -n -e 's/.*git:[^0-9]*\([0-9\.]*\).*/\1/p'
}

parse_git_version() {
    git -v 2> /dev/null | sed -n -e 's/.*git[^0-9]*\([0-9\.]*\).*/\1/p'
}

if [ "$(parse_git_version)" != "$(parse_new_git_version)" ]
    then
    echo "Upgrade GIT: $(parse_git_version) >>> \u001b[31m$(parse_new_git_version)\033[0m"
fi
