# export CC=`which gcc`

alias dconf='make CC=$CC defconfig'
alias kconf='make CC=$CC kvmconfig'
alias dkconf='dconf && kconf'
alias uconf='node ../update-config.js'
alias oconf='make CC=$CC olddefconfig'
alias mkconf='dkconf && uconf && oconf && uconf && $CC -v 2>CC'
alias paddr='git am ../patches/0001-selinux-use-kernel-linux-socket.h-for-genheaders-and.patch'
alias mk='make CC=$CC'

lunch() {
  if [ "$1" = "" ]; then
    echo Please specify a kernel version, e.g., v4.17
    echo Usage:
    echo "  lunch <version> [image=buster.img] [key=buster.id_rsa]"
    return 1
  fi
  export KERNEL=`pwd`/$1
  export IMAGE=${2:-buster.img}
  export KEY=${3:-buster.id_rsa}
  echo KERNEL=$KERNEL
  echo IMAGE=$IMAGE
  echo KEY=$KEY
}

start() {
  export PORT=${1:-10022}
  echo "Guest port 22 => host port $PORT"
  echo Starting VM via \`screen\`
  screen -d -m qemu-system-x86_64 \
    -m 2G \
    -smp 8 \
    -kernel $KERNEL/arch/x86/boot/bzImage \
    -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
    -drive file=$IMAGE,format=raw \
    -device e1000,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp:127.0.0.1:$PORT-:22 \
    -enable-kvm \
    -nographic \
    -pidfile vm.pid \
    -snapshot
}

stop() {
  if [ ! -f vm.pid ]; then
    echo 'Error: PID file "vm.pid" does not exist, the VM might have stopped'
    return 1
  fi
  pid=`cat vm.pid`
  kill $pid && echo Stopped VM process $pid
}

_checkKeyAndPort() {
  if [ "$KEY" = "" ]; then
    echo Error: environment variable KEY not set
    return 1
  fi
  if [ "$PORT" = "" ]; then
    echo Error: environment variable PORT not set
    return 1
  fi
  return 0
}

conn() {
  if _checkKeyAndPort; then
    ssh -i $KEY -p $PORT -o "StrictHostKeyChecking no" root@localhost
  else
    return 1
  fi
}
alias con='conn'

file() {
  if _checkKeyAndPort; then
    sftp -o StrictHostKeyChecking=no -i $KEY -P $PORT root@localhost
  else
    return 1
  fi
}
