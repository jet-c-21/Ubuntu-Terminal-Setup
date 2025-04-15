#!/bin/bash
set -e

# version: 1.0.1

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ask user input sudo password >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
if [[ -z "${SUDO_PASSWORD}" ]]; then
  echo "[*INFO*] - during installation, your fonts might be strange, do not worry, it will be fixed after installation"
  echo -n "[*INFO*] - Please enter your sudo password: "
  read -s user_input_password
  echo
  verify_password() {
    echo "$1" | sudo -S -v &>/dev/null
  }
  if verify_password "$user_input_password"; then
    export SUDO_PASSWORD="$user_input_password"
    echo "$SUDO_PASSWORD" | sudo -S -v &>/dev/null
  else
    echo "[*ERROR*] - Incorrect password." >&2
    exit 1
  fi
fi
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< ask user input sudo password <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> use and unlock sudo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
use_sudo() { # sudo experiment wrapper function
  : <<COMMENT
straight way:
  echo "$SUDO_PASSWORD" | sudo -S your command
example:
  echo "$SUDO_PASSWORD" | sudo -S apt-get update
COMMENT

  local cmd="echo ${SUDO_PASSWORD} | sudo -SE "
  for param in "$@"; do
    cmd+="${param} "
  done
  eval "${cmd}"
}

unlock_sudo() {
  local command="whoami"
  local result="$(use_sudo "$command")"
  echo "[*INFO*] - unlock $result privilege"
}
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< use and unlock sudo <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> parse user input args >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
USER_OPT_LAUNCH_ZSH=true
USER_OPT_LAUNCH_UBUNTU_DEJAVU=false

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --launch-zsh)
      USER_OPT_LAUNCH_ZSH=true
      ;;
    --no-launch-zsh)
      USER_OPT_LAUNCH_ZSH=false
      ;;
    --launch-ubuntu-dejavu)
      USER_OPT_LAUNCH_UBUNTU_DEJAVU=true
      ;;
    --no-launch-ubuntu-dejavu)
      USER_OPT_LAUNCH_UBUNTU_DEJAVU=false
      ;;
    --help)
      echo "Usage: $0 [OPTIONS]"
      echo "Options:"
      echo "  --launch-zsh                Launch zsh after installation (default)"
      echo "  --no-launch-zsh             Do not launch zsh after installation"
      echo "  --launch-ubuntu-dejavu      Launch Ubuntu Dejavu setup after install"
      echo "  --no-launch-ubuntu-dejavu   Do not launch Ubuntu Dejavu setup"
      echo "  --help                      Display this help message"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help to see the valid options."
      exit 1
      ;;
  esac
  shift
done
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< parse user input args <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
  echo "finish cloning all zsh plugins"

  # Update .zshrc
  sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc
  echo "finish change zsh to powerlevel10k"

  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc
  echo "finish adding all zsh plugins in ~/.zshrc"

  curl -o ~/.p10k.zsh https://raw.githubusercontent.com/jet-c-21/Ubuntu-Terminal-Setup/refs/heads/main/.p10k.zsh
  echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
  echo "finish adding powerlevel10k configuration in ~/.zshrc"

  echo "finish installing powerlevel10k"
}

change_hist_stamps_in_zshrc_file() {
  local user_zshrc_file="$HOME/.zshrc"
  local hist_stamp_pattern='^HIST_STAMPS='
  local hist_stamp_comment='# HIST_STAMPS="mm/dd/yyyy"'
  local hist_stamp_new='HIST_STAMPS="%F %T "'

  # Return if .zshrc does not exist
  if [[ ! -f "$user_zshrc_file" ]]; then
    echo "[*INFO*] - $user_zshrc_file does not exist, no changes made"
    return
  fi

  # Return if HIST_STAMPS is already set
  if grep -qE "$hist_stamp_pattern" "$user_zshrc_file"; then
    echo "[*INFO*] - HIST_STAMPS seems already set in $user_zshrc_file, no change"
    return
  fi

  # Replace commented HIST_STAMPS line if present
  if grep -qF "$hist_stamp_comment" "$user_zshrc_file"; then
    sed -i "s|$hist_stamp_comment|$hist_stamp_new|" "$user_zshrc_file"
    echo "[*INFO*] - Updated HIST_STAMPS in $user_zshrc_file"
    return
  fi

  # Append HIST_STAMPS to the file
  printf "\n%s\n" "$hist_stamp_new" >> "$user_zshrc_file"
  echo "[*INFO*] - Added HIST_STAMPS in $user_zshrc_file"
}

launch_ubuntu_dejavu() {
  cd "${Home}"

  git clone https://github.com/jet-c-21/Ubuntu-Dejavu.git
  cd Ubuntu-Dejavu
  chmod +x scripts/*
  ./scripts/ubuntu_dejavu.sh
}

main () {
  echo "start installing new shell for user: $(whoami) ..."

  add_emoji_and_fonts
  change_gnome_terminal_profile_setting
  install_ohmyzsh
  install_powerlevel10k
  change_hist_stamps_in_zshrc_file

    # Handle Ubuntu Dejavu launch — overrides zsh launch if set
  if [ "$USER_OPT_LAUNCH_UBUNTU_DEJAVU" = true ]; then
    echo "Launching Ubuntu Dejavu setup script..."
    USER_OPT_LAUNCH_ZSH=false
    launch_ubuntu_dejavu
  fi


  if [ "$USER_OPT_LAUNCH_ZSH" = true ]; then
    echo "Done! Let's Enjoy your new shell 🍻"
    exec zsh
  else
    echo "Done! You can manually start zsh by running 'zsh' command 🍻"
  fi
}

# at the bottom of your all_in_one.sh
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
