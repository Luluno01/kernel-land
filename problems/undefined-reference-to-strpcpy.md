# undefined reference to stpcpy

This is a Clang specific problem.

Fixed by commit 1e1b6d63d6340764e00356873e5794225a2a03ea.

## Solution

Apply patch `0001-lib-string.c-implement-stpcpy.patch`.
