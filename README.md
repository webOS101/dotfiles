dotfiles
========

New mac configuration files.  Copy the dotfiles (except .osx) to ~.  Execute .osx to set system-wide settings.

.osx is fully documented and is based on one from http://mths.be/osx

There is a set of VIM plugins available here: https://github.com/webOS101/vimplugins.git

Basically:

    sh .osx
    cp .gvimrc .inputrc .git-prompt.sh ~
    ln -s /Users/yourname/.../dotfiles/.vimrc ~/.vimrc
	ln -s /Users/yourname/.../dotfiles/.bash_profile_shared ~/.bash_profile_shared
    echo "source ~/.bash_profile_shared" >> ~/.bash_profile
