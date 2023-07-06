# Ubuntu-Terminal-Setup

Change Terminal to zsh + oh my zsh + powerlevel10k

## Installation

#### Start with git clone and jump to step 2.

```shell
cd ~ && sudo apt install -y git && \
git clone https://github.com/jet-c-21/Ubuntu-Terminal-Setup.git && \
cd Ubuntu-Terminal-Setup && ./add_fonts.sh 
```

#### 1. Install Fonts

```shell
./add_fonts.sh
```

#### 2. Once you see the ```oh-my-zsh``` logo, change the terminal to:

```shell
Meslo NF
```

Note: If don't don't see the Meslo NF font in the scroll down list, reopen the terminal, and change the font, then:

```
reboot
```

#### 3. run the following command

```shell
cd ~ && \
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z && \
sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc && \
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc && \
source ~/.zshrc
```

#### 4. reboot or logout

```shell
sudo reboot
```

## In docker Container

```shell
cd ~ && apt update && apt install -y git unzip fontconfig && \
git clone https://github.com/jet-c-21/Ubuntu-Terminal-Setup.git && \
cd Ubuntu-Terminal-Setup && ./docker_add_fonts.sh 
```

```shell
cd ~ && \
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z && \
sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc && \
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc && \
source ~/.zshrc
```

## In AWS EC2 Instance

```shell
cd ~ && sudo apt update && sudo apt install -y git unzip fontconfig && \
git clone https://github.com/jet-c-21/Ubuntu-Terminal-Setup.git && \
cd Ubuntu-Terminal-Setup && ./aws_ec2_add_fonts.sh
```

```shell
cd ~ && \
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z && \
sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc && \
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc && \
source ~/.zshrc
```

## QNAP

```shell
cd ~ && opkg update && opkg install -y fontconfig && \
git clone https://github.com/jet-c-21/Ubuntu-Terminal-Setup.git && \
cd Ubuntu-Terminal-Setup && ./qnap_add_fonts.sh
```

```shell
cd ~ && \
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z && \
sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc && \
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc && \
source ~/.zshrc
```

## Other Command

#### re-config p10k

```shell
p10k configure
```
