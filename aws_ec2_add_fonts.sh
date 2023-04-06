set -e
sudo apt install -y fonts-noto-color-emoji
sudo rm -rf /usr/share/fonts/truetype/MesloLGS_NF
wget -O MesloLGS_NF.zip https://github.com/jet-c-21/MyFonts/releases/download/1.0.0/MesloLGS_NF.zip
unzip -q MesloLGS_NF.zip
rm -rf MesloLGS_NF.zip
sudo mv -f MesloLGS_NF /usr/share/fonts/truetype/
sudo fc-cache -f -v
clear
echo "finish added fonts"

sudo apt install -y git wget curl wget zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
