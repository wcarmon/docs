# Overview
1. How to find and terminate unnecessary processes & services


# Processes using Highest CPU
```ps1
Get-Process | Sort-Object CPU -Descending | Select-Object -First 30 -Property ProcessName, Path
```


# Processes using Highest Memory
```ps1
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 20 -Property ProcessName, Path
```


# Stop a Service
```ps1
Stop-Service -Name "Print Spooler"
Stop-Service -Name "Smart Card"
Stop-Service -Name "..."
```


# Stop a Process
```ps1
Get-Process | Where-Object { $_.ProcessName -eq "msedge" } | Stop-Process -Force
```


# Other resources
1. TODO
