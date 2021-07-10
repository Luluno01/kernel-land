# `undefined reference to \`bcmp'`

Clang fails to build with the following error:

```
ld: init/do_mounts.o: in function `prepare_namespace':
***/init/do_mounts.c:593: undefined reference to `bcmp'
```

See [here](https://patchwork.kernel.org/project/linux-kbuild/patch/20190312215203.27643-1-natechancellor@gmail.com/).

Possible [alternative solution](https://patchwork.kernel.org/project/linux-kbuild/patch/20190313180239.261938-1-ndesaulniers@google.com/).

## Solution

Apply patch `Makefile-Add--fno-builtin-bcmp-to-CLANG_FLAGS.diff`.

