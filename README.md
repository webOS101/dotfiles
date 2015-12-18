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

It is also helpful to add the following to `~/Library/KeyBindings/DefaultKeyBinding.dict`

```
{
    /* Remap Home / End to be correct :-) */
    "\UF729"  = "moveToBeginningOfLine:";                   /* Home         */
    "\UF72B"  = "moveToEndOfLine:";                         /* End          */
    "$\UF729" = "moveToBeginningOfLineAndModifySelection:"; /* Shift + Home */
    "$\UF72B" = "moveToEndOfLineAndModifySelection:";       /* Shift + End  */
}
```
