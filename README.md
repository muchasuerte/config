# Config

configuration files

## Vim

**vimbootstrap.sh**:  
install vim vundle and vim plugin configuration files  
[vundle](https://github.com/gmarik/vundle)  

### vim-plugins:
* Git wrapper  
[fugitive](https://github.com/tpope/vim-fugitive)  

* fork MiniBufExpl  
[MiniBufExpl](https://github.com/fholgado/minibufexpl.vim) 

* Allows you to explore your filesystem  
[nerdtree](https://github.com/scrooloose/nerdtree)
  
* A code-completion engine for Vim  
[YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
> **require plugin build:**  
>> ~/.vim/bundle/YouCompleteMe$ ./install.sh --clang-completer  

> **fix for ubuntu :**
>>   sudo ln -s /usr/lib/llvm-3.4/lib /usr/lib/llvm  
> **sudo apt-get install libclang-3.4-dev**  
> ./install.sh --clang-completer --system-libclang

* Syntax checking hacks for vim  
[syntastic](https://github.com/scrooloose/syntastic)

* A forked script for vim auto reloading of buffers when changed on disk.  
[vim-autoreadwatch](https://github.com/mutewinter/vim-autoreadwatch)

* Extended session management for Vim (:mksession on steroids)  
[vim-misc](https://github.com/vim-misc)  
[vim-session](https://github.com/xolox/vim-session)

### vim-commands
 * &lt;Leader&gt; key is mapped to '\' by default.

#### vertically/horizontal split windows

* Ctrl+W, S (upper case) for horizontal splitting
* Ctrl+W, v (lower case) for vertical splitting
* Ctrl+W, Q to close one
* Ctrl+W, Ctrl+W to switch between windows
* Ctrl+W, J (xor K, H, L) to switch to adjacent window (intuitively up, down, left, right)


## Grub Utils
* copy 60_isoboot to /etc/grub.d/60_isoboot
* chmod a+x /etc/grub.d/60_isoboot
* make dir /boot/images
* Then place your ISO in the directory /boot/images/
* Now just run "update-grub" and the ISO will automatically be added to the  
  GRUB boot menu, and you can boot from it directly from the GRUB boot menu.

