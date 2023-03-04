#!/bin/bash

#######################
#### Base Packages ####
#######################

mkdir ~/software
export SOFTWARE_INSTALL=~/software

### Essentials
sudo apt install -y curl
sudo apt install -y vim


### ZSH and Oh My Zsh
sudo apt install -y zsh
sudo apt-get install -y fonts-font-awesome \
	fzf 

#wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
#wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
#mkdir -p ~/.local/share/fonts/
#mv PowerlineSymbols.otf ~/.local/share/fonts/
#fc-cache -vf ~/.local/share/fonts/
#mkdir -p ~/.config/fontconfig/conf.d/
#mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

#git clone https://github.com/abertsch/Menlo-for-Powerline.git
#sudo mv Menlo-for-Powerline/Menlo*.ttf /usr/share/fonts/
#rm -rf Menlo-for-Powerline  # clean up

# MESLO NERD FONT
wget -P ~/.local/share/fonts/ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

wget -P ~/.local/share/fonts/ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf


wget -P ~/.local/share/fonts/ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf


wget -P ~/.local/share/fonts/ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf


export ZSH_CUSTOM=~/.oh-my-zsh/custom/

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# autosuggestion & syntax highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting


# enable good fuzzy search
sudo apt install -y fzf
sed -i '$ a # fzf - Better Reverse Search' ~/.zshrc
sed -i '$ a source /usr/share/doc/fzf/examples/key-bindings.zsh' ~/.zshrc
sed -i '$ a source /usr/share/doc/fzf/examples/completion.zsh' ~/.zshrc

# autojump
git clone https://github.com/wting/autojump.git $SOFTWARE_INSTALL/autojump
cd $SOFTWARE_INSTALL/autojump
python3 install.py
cd ..
sed -i '$ a # Autojump requirements' ~/.zshrc
sed -i '$ a [[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh' ~/.zshrc
sed -i '$ a autoload -U compinit && compinit -u' ~/.zshrc 

sed -i 's@^ZSH_THEME=.*$@ZSH_THEME="powerlevel10k/powerlevel10k"@g' ~/.zshrc
sed -i 's@plugins=(git)@plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump extract)@g' ~/.zshrc


# make zsh the default shell
chsh -s /bin/zsh
