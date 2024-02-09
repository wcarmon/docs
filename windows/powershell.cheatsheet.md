# Overview:

1. Common Powershell commands
1. Help for people with linux/bash muscle memory

# Find location of a binary: [Get-Command](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-command?view=powershell-7.4)

```powershell
function which([string]$cmd) {gcm -ErrorAction "SilentlyContinue" $cmd | ft Definition}
```

1. Linux: [`which`](https://linux.die.net/man/1/which)
1. `gcm` is an alias for `Get-Command`
1. `ft` means [`Format-Table`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-table?view=powershell-7.4)

- TODO: how to predefine for all powershells: $profile.AllUsersAllHosts

# Find files by name: [Get-ChildItem](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4)

```powershell
ls -r -force -include "app*.properties"
gci -r -force -include "app*.properties"

Get-ChildItem -Recurse -Force -Path . -Include "app*.properties"
```

1. Linux: [`find`](https://linux.die.net/man/1/find)
1. `-Path .` is implied
1. [`-Force`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-force) includes hidden files
    1. `-f` fails as a shorter alternative :-(
1. [`-Include` syntax](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4#-include)
1. `ls` and `gci` are aliases for [`Get-ChildItem`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4)
1. `-Recurse` and `-r` are equivalent
1. Flags can be UPPER CASE or lower case
1. Flag order is irrelevant
1. TODO: multiple patterns with AND  <-- complicated, uses `Where-Object`
1. TODO: multiple patterns with OR

# Find files by content

```powershell
ls -r | sls "foo" -list | Select Path
gci -r | sls "foo" -list | Select Path 

Get-ChildItem -Recurse | Select-String "foo" -List | Select Path
```

1. Linux: [`grep`](https://linux.die.net/man/1/grep)
1. `sls` is an alias for [`Select-String`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-string?view=powershell-7.4)

# TODO: figure out these:

- TODO: pipe to sort (Sort-Object)
- TODO: pipe to grep
