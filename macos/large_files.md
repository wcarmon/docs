# Overview

1. Finding large files

# Terminal

```bash
du -sh *  | grep -E "\dG"
mdfind 'kMDItemFSSize > 2000000000'
```

## [Baobab](https://wiki.gnome.org/action/show/Apps/DiskUsageAnalyzer?action=show&redirect=Apps%2FBaobab)

```bash
brew install baobab
baobab .
```

# Other Resources

1. https://apple.stackexchange.com/questions/118167/how-do-i-quickly-find-large-files-and-folders-on-my-mac
1. https://nektony.com/how-to/find-the-largest-files-on-macos
1. https://macmost.com/using-terminal-to-find-large-files-and-folders.html
1. https://formulae.brew.sh/formula/baobab
