# "New address family defined, ..."

Fixed by commit dfbd199a7cfe3e3cd8531e1353cdbd7175bfbc5e.

See [https://lore.kernel.org/selinux/20190225005528.28371-1-paulo@paulo.ac/](https://lore.kernel.org/selinux/20190225005528.28371-1-paulo@paulo.ac/) for more details

## Solution

Backport commit dfbd199a7cfe3e3cd8531e1353cdbd7175bfbc5e.

```bash
git cherry-pick dfbd199a7cfe3e3cd8531e1353cdbd7175bfbc5e
```

Or make patch files and apply them:

```bash
git format-patch -1 dfbd199a7cfe3e3cd8531e1353cdbd7175bfbc5e

# cd v4.17-rc1
git am xxx.patch
```
