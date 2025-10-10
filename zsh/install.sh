BASH_SCRIPT=$(dirname $(realpath "$0"))/.zshrc

echo "Install zsh extras from $BASH_SCRIPT"

echo "source $BASH_SCRIPT" >> ~/.zshrc
