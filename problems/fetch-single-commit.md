# How to fetch single commit

Enable `uploadpack.allowReachableSHA1InWant` in remote repository if not:

```bash
git config uploadpack.allowReachableSHA1InWant true
```

Then, in the local repository:

```bash
git fetch --depth=1 <repo, e.g. /a/b/c.git> <commit>
```
