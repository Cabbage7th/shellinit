#!/bin/sh

[ -z "$APP_PATH" ] && APP_PATH="$HOME/.shellinit"
[ -z "$REPO_URI" ] && REPO_URI='https://github.com/Cabbage7th/shellinit.git'
[ -z "$ZSH_CUSTOME_PATH" ] && ZSH_CUSTOME_PATH="$HOME/.oh-my-zsh/custom/"
[ -z "$CUSTOM_PLUGIN_PATH" ] && CUSTOM_PLUGIN_PATH="$ZSH_CUSTOME_PATH/plugins/"

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

# 0. download shellinit
mkdir -p $APP_PATH
git clone "$REPO_URI" "$APP_PATH"
ret="$?"
success "clone shellinit successfully"

# 1. install oh my zsh
 #sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
 #ret="$?"
 #success "install oh my zsh successfully"

# 2. download extra plugins
if [ -e "$CUSTOM_PLUGIN_PATH" ]; then
    cd $CUSTOM_PLUGIN_PATH
    git clone https://github.com/zsh-users/zsh-autosuggestions.git
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi
# 3. download powerlevel10k theme
if [ -e "$ZSH_CUSTOME_PATH" ]; then
    cd $ZSH_CUSTOME_PATH/themes
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    cp -rf powerlevel10k/* ./
fi

ret="$?"
success "clone extra plugins successfully"


# 3. link custom configuration file
cd $HOME
ln -sf $APP_PATH/custom.sh $ZSH_CUSTOME_PATH/custom.zsh
ret="$?"
success "init custom configuration successfully"

# 4. enable plugins
#linenum=`sed -n -e '/plugins=(/=' $HOME/.zshrc`
#sed -e ''$linenum'c/plugins(' $HOME/.zshrc
#sed -e ''$linenum'a/git' $HOME/.zshrc
#linenum=$((linenum+1))
#sed -e ''$linenum'a/z' $HOME/.zshrc
#linenum=$((linenum+1))
#sed -e ''$linenum'a/vi-mode' $HOME/.zshrc
#linenum=$((linenum+1))
#sed -e ''$linenum'a/zsh-autosuggestions' $HOME/.zshrc
#linenum=$((linenum+1))
#sed -e ''$linenum'a/zsh-syntax-highlighting' $HOME/.zshrc
#linenum=$((linenum+1))
#sed -e ''$linenum'a/sudo' $HOME/.zshrc
#linenum=$((linenum+1))
#sed -e ''$linenum'a/fzf' $HOME/.zshrc
#linenum=$((linenum+1))
#sed -e ''$linenum'a/)' $HOME/.zshrc
