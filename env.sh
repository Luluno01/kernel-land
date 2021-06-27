# export CC=`which gcc`

alias dconf='make CC=$CC defconfig'
alias kconf='make CC=$CC kvmconfig'
alias dkconf='dconf && kconf'
alias uconf='node ../update-config.js'
alias oconf='make CC=$CC olddefconfig'
alias mkconf='dkconf && uconf && oconf && uconf && $CC -v 2>CC'
alias paddr='git am ../linux.git/0001-selinux-use-kernel-linux-socket.h-for-genheaders-and.patch'
alias mk='make CC=$CC'

