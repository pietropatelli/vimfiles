# PietroPate/vimfiles

My vim configuration and, in the `otherstuff` directory, two methods of mapping the CapsLock key to Escape and a modified Italian keyboard for windows. 

### Installing this configuration:

- Use `git clone --recurse-submodules https://github.com/PietroPate/vimfiles` to include minpac (or `git submodule update --init --recursive` if the local vimfiles clone exists already).
-  Run `:PUpdate` in vim to install all plugins.

### Note on using vim with python:

- Vim needs to be compiled with the appropriate option.
- In Windows, the installed python and vim must both be 32 or 64 bit. I use the 64 bit vim from tuxproject, which can be installed using chocolatey (`choco install vim-tux`) or downloaded [here](https://tuxproject.de/projects/vim/).
