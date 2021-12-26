#!/usr/bin/env bash
# Update my git dotfiles folder automatically
if [[ ! -d $HOME/bin ]]; then
    ln -s $HOME/git/dotfiles/bin $HOME/bin
fi
if [[ ! -d $HOME/.bashrc.d ]]; then
    ln -s $HOME/git/dotfiles/.bashrc.d $HOME/.bashrc.d
fi
if [[ ! -f $HOME/.bashrc ]]; then
    ln -s ~/git/dotfiles/.bashrc $HOME/.bashrc
fi
if [[ ! -d $HOME/vimwiki ]]; then
    ln -s $HOME/git/dotfiles/vimwiki $HOME/vimwiki
fi
if [[ ! -f $HOME/.config/starship.toml ]]; then
    cp $HOME/git/dotfiles/starship.toml $HOME/.config/starship.toml
fi
if [[ ! -f $HOME/.vimrc ]]; then
    ln -s $HOME/git/dotfiles/.vimrc $HOME/.vimrc
fi
