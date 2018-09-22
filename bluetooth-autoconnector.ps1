#!/usr/bin/pwsh-preview

param(
    [Parameter(Mandatory=$true)]
    [string]$mac
)

[string]$status = "info $mac" | bluetoothctl

if($status -notlike '*Missing*' -and $status -notlike '*Connected: yes*'){
    "connect $mac" | bluetoothctl
}