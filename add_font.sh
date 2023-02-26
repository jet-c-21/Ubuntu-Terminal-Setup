use_sudo() {
  : <<COMMENT
straight way:
  echo "$sudo_pwd" | sudo -S your command
example:
  echo "$sudo_pwd" | sudo -S apt-get update
COMMENT

  local cmd="echo ${sudo_pwd} | sudo -S "
  for param in "$@"; do
    cmd+="${param} "
  done
  eval "${cmd}"
}

echo "Please enter your sudo password:"
read -s sudo_pwd

use_sudo rm -rf /usr/share/fonts/truetype/MesloLGS_NF
wget -O MesloLGS_NF.zip https://github.com/jet-c-21/MyFonts/releases/download/1.0.0/MesloLGS_NF.zip
unzip -q MesloLGS_NF.zip
rm -rf MesloLGS_NF.zip
use_sudo mv -f MesloLGS_NF /usr/share/fonts/truetype/
use_sudo fc-cache -f -v
clear

echo "finish added fonts"

use_sudo apt install -y wget curl wget zsh
use_sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

use_sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
use_sudo curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
use_sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
use_sudo apt update
use_sudo apt install sublime-text
