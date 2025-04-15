# Ubuntu-Terminal-Setup

Change Terminal to zsh + oh my zsh + powerlevel10k

## Quick Install

#### On Normal Ubuntu Machine

```shell
cd ~ && \
git clone https://github.com/jet-c-21/Ubuntu-Terminal-Setup.git && \
cd Ubuntu-Terminal-Setup && ./quick_install.sh
```

#### On Docker Container

```shell
cd ~ && git clone https://github.com/jet-c-21/Ubuntu-Terminal-Setup.git && cd Ubuntu-Terminal-Setup && ./quick_install_on_docker_container.sh
```

#### On AWS EC2 or GCP VM

```shell
cd ~ && git clone https://github.com/jet-c-21/Ubuntu-Terminal-Setup.git && cd Ubuntu-Terminal-Setup && ./quick_install_on_aws_ec2.sh
```

## Desktop Option: Launch with Ubuntu-Dejavu
```shell
cd ~ && \
git clone https://github.com/jet-c-21/Ubuntu-Terminal-Setup.git && \
cd Ubuntu-Terminal-Setup && ./quick_install.sh --launch-ubuntu-dejavu
```

## Manual Installation

#### Start with git clone and jump to step 3.

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

##### The following command will enable my personal preferred configuration, the tricks is:

```shell
curl -o ~/.p10k.zsh https://raw.githubusercontent.com/jet-c-21/Ubuntu-Terminal-Setup/refs/heads/main/.p10k.zsh && \
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc && \
```

you can remove this two line to enable custom setting dialog, or simply run `p10k configure` after the installation to
evoke the custom setup dialog

```shell
cd ~ && \
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z && \
sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc && \
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc && \
curl -o ~/.p10k.zsh https://raw.githubusercontent.com/jet-c-21/Ubuntu-Terminal-Setup/refs/heads/main/.p10k.zsh && \
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc && \
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
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z && \
sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc && \
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc && \
curl -o ~/.p10k.zsh https://raw.githubusercontent.com/jet-c-21/Ubuntu-Terminal-Setup/refs/heads/main/.p10k.zsh && \
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc && \
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
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z && \
sed -i "/^ZSH_THEME=/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc && \
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions z zsh-syntax-highlighting)/g' ~/.zshrc && \
curl -o ~/.p10k.zsh https://raw.githubusercontent.com/jet-c-21/Ubuntu-Terminal-Setup/refs/heads/main/.p10k.zsh && \
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc && \
source ~/.zshrc
```

## Other Command

#### re-config p10k

```shell
p10k configure
```
