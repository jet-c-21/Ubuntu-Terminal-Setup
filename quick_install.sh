#!/bin/bash
set -e

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> fetch SUDO_PASSWD from user >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
echo "Please enter your sudo password:"
read -s user_input_sudo_password
is_sudo_password() {
  local password=$1
  echo $password | sudo -S true 2>/dev/null
  return $?
}

if is_sudo_password "$user_input_sudo_password"; then
    SUDO_PASSWD=$user_input_sudo_password
else
    echo "Error: Incorrect sudo password." >&2
  exit 1
fi
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< fetch SUDO_PASSWD from user <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> unlock_sudo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
use_sudo() {
  : <<COMMENT
straight way:
  echo "$SUDO_PASSWD" | sudo -S your command
example:
  echo "$SUDO_PASSWD" | sudo -S apt-get update
COMMENT

  local cmd="echo ${SUDO_PASSWD} | sudo -SE "
  for param in "$@"; do
    cmd+="${param} "
  done
  eval "${cmd}"
}

unlock_sudo() {
  local command="whoami"
  local result="$(use_sudo "$command")"
  echo "[INFO] - unlock $result privilege"
}

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< unlock_sudo <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

add_emoji_and_fonts() {
  unlock_sudo
  sudo apt install -y fonts-noto-color-emoji

  unlock_sudo
  sudo rm -rf /usr/share/fonts/truetype/MesloLGS_NF

  #wget -O MesloLGS_NF.zip https://github.com/jet-c-21/MyFonts/releases/download/1.0.0/MesloLGS_NF.zip
  unzip -q MesloLGS_NF.zip

  unlock_sudo
  sudo mv -f MesloLGS_NF /usr/share/fonts/truetype/

  unlock_sudo
  sudo fc-cache -f -v

  clear
  echo "finish added fonts"
}

change_gnome_terminal_profile_setting() {
  DEFAULT_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default) && \
  DEFAULT_PROFILE=${DEFAULT_PROFILE:1:-1} && \
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$DEFAULT_PROFILE/ font 'MesloLGS NF Regular 12' && \
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$DEFAULT_PROFILE/ use-system-font false

  echo "finish changing gnome terminal profile setting"
}

install_ohmyzsh() {
  unlock_sudo
  sudo apt install -y git wget curl wget zsh

  # Auto confirm prompts for Oh My Zsh installation and change shell
  echo "y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "finish running ohmyzsh install shell"

  # Change the default shell to zsh without prompting
  unlock_sudo
  sudo chsh -s $(which zsh) $(whoami)
  echo "finish changing default shell to zsh"
}

install_powerlevel10k(){
  echo "installing powerlevel10k ..."
  cd ~
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z && \
  sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc && \
  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc && \
  curl -o ~/.p10k.zsh https://raw.githubusercontent.com/jet-c-21/Ubuntu-Terminal-Setup/master/.p10k.zsh && \
  echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc && \
  source ~/.zshrc
  echo "finish installing powerlevel10k"
}

main () {
#  add_emoji_and_fonts # passed test
#  change_gnome_terminal_profile_setting # passed test
  install_ohmyzsh
  install_powerlevel10k

  sleep 500
}

main