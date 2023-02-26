# Ubuntu-Terminal-Setup

Change Terminal to zsh + oh my zsh + powerlevel10k

```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```


```shell
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
```

```shell
subl ~/.zshrc
```

edit

```shell
ZSH_THEME="powerlevel10k/powerlevel10k"
```

```shell
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-z)
```