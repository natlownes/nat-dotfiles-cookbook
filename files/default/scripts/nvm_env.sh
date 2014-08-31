source ~/.bin/source_bash.zsh

os=$(uname)
export NVM_DIR=$HOME/.nvm

if [ -r $NVM_DIR ]; then
  # TODO:  figure out wtf
  if [ $os = 'Linux' ]; then
    source_bash $NVM_DIR/nvm.sh
  fi

  if [ $os = 'Darwin' ]; then
    source $NVM_DIR/nvm.sh
  fi
fi
