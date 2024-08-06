#!/bin/bash
set -e

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> parse user input args >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
USER_OPT_LAUNCH_ZSH=true

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --launch_zsh)
      USER_OPT_LAUNCH_ZSH=true
      ;;
    --no_launch_zsh)
      USER_OPT_LAUNCH_ZSH=false
      ;;
    --help)
      echo "Usage: $0 [OPTIONS]"
      echo "Options:"
      echo "  --launch_zsh        Launch zsh after installation (default)"
      echo "  --no_launch_zsh     Do not launch zsh after installation"
      echo "  --help              Display this help message"
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
  apt update && apt install -y unzip git wget curl wget fonts-noto-color-emoji

  rm -rf /usr/share/fonts/truetype/MesloLGS_NF

  #wget -O MesloLGS_NF.zip https://github.com/jet-c-21/MyFonts/releases/download/1.0.0/MesloLGS_NF.zip
  unzip -q MesloLGS_NF.zip

  mv -f MesloLGS_NF /usr/share/fonts/truetype/

  fc-cache -f -v

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
  apt install -y git wget curl wget zsh

  # Auto confirm prompts for Oh My Zsh installation and change shell
  echo "y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "finish running ohmyzsh install shell"

  # Change the default shell to zsh without prompting
  chsh -s $(which zsh) $(whoami)
  echo "finish changing default shell to zsh"
}

install_powerlevel10k(){
  echo "installing powerlevel10k ..."

  cd ~
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
  echo "finish cloning all zsh plugins"

  # Update .zshrc
  sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc
  echo "finish change zsh to powerlevel10k"

  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc
  echo "finish adding all zsh plugins in ~/.zshrc"

  curl -o ~/.p10k.zsh https://raw.githubusercontent.com/jet-c-21/Ubuntu-Terminal-Setup/master/.p10k.zsh
  echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
  echo "finish adding powerlevel10k configuration in ~/.zshrc"

  echo "finish installing powerlevel10k"
}

main () {
  echo "start installing new shell for user: $(whoami) ..."

  add_emoji_and_fonts
  change_gnome_terminal_profile_setting
  install_ohmyzsh
  install_powerlevel10k

  if [ "$USER_OPT_LAUNCH_ZSH" = true ]; then
    echo "Done! Let's Enjoy your new shell 🍻"
    exec zsh
  else
    echo "Done! You can manually start zsh by running 'zsh' command 🍻"
  fi
}

main
