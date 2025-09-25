BASH_SCRIPT=$(dirname $(realpath "$0"))/.bashrc

echo "Install bash extras from $BASH_SCRIPT"

echo "source $BASH_SCRIPT" >> ~/.bashrc
