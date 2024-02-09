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
ls -path . -include "app*.properties" -recurse -force
gci -path . -include "app*.properties" -recurse -force
Get-ChildItem -Path . -Include "app*.properties" -Recurse -Force
```

1. Linux: [`find`](https://linux.die.net/man/1/find)
1. [`-Force`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-force) includes hidden files
1. [`-Include` syntax](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-include)
1. `ls` and `gci` are aliases for `Get-ChildItem`
1. TODO: short flags?
1. Flags can be UPPER CASE or lower case
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
