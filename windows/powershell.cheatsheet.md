# Overview:

- Common Powershell commands

# Find location of a binary: [Get-Command](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-command?view=powershell-7.4)

```powershell
function which([string]$cmd) {gcm -ErrorAction "SilentlyContinue" $cmd | ft Definition}
```

1. Linux: [`which`](https://linux.die.net/man/1/which)
1. `gcm` is an alias for `Get-Command`
1. `ft` means [`Format-Table`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-table?view=powershell-7.4)

- TODO: how to predefine for all powershells

# Find files by name: [Get-ChildItem](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4)

```powershell
gci -Path . -Include "app*.properties" -Recurse -Force
ls -Path . -Include "app*.properties" -Recurse -Force

Get-ChildItem -Path . -Filter "app*.properties" -Recurse -Force
Get-ChildItem -Path . -Include "app*.properties" -Recurse -Force
```

1. Linux: [`find`](https://linux.die.net/man/1/find)
1. [`-Force`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-force) includes hidden files
1. [`-Filter`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-filter) is per `Path`
1. [`-Include`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-include) is for the whole command
1. `ls` and `gci` are aliases for `Get-ChildItem`
1. TODO: short flags?
1. TODO: lower case flags?
1. TODO: then pipe to grep

# Find files by content

```powershell
TODO
Get-ChildItem -Recurse | Select-String "foo" -List | Select Path
```
1. Linux: [`grep`](https://linux.die.net/man/1/grep)
1. [`Select-String`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-string?view=powershell-7.4)
1. TODO:

# ...

- TODO: pipe to sort (Sort-Object)
- TODO: pipe to grep
