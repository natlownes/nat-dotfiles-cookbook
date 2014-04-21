source ~/.bin/source_bash.zsh

export NVM_DIR=$HOME/.nvm

if [ -r $NVM_DIR ]; then
    source_bash $NVM_DIR/nvm.sh
fi
