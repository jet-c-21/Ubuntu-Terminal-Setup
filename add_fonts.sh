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

#echo "Please enter your sudo password:"
#read -s sudo_pwd

sudo apt install -y fonts-noto-color-emoji
sudo rm -rf /usr/share/fonts/truetype/MesloLGS_NF
wget -O MesloLGS_NF.zip https://github.com/jet-c-21/MyFonts/releases/download/1.0.0/MesloLGS_NF.zip
unzip -q MesloLGS_NF.zip
rm -rf MesloLGS_NF.zip
sudo mv -f MesloLGS_NF /usr/share/fonts/truetype/
sudo fc-cache -f -v
clear
echo "finish added fonts"

DEFAULT_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default) && \
DEFAULT_PROFILE=${DEFAULT_PROFILE:1:-1} && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$DEFAULT_PROFILE/ font 'MesloLGS NF Regular 12' && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$DEFAULT_PROFILE/ use-system-font false

sudo apt install -y git wget curl wget zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
