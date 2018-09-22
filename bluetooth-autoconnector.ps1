#!/usr/bin/pwsh-preview

param(
    [Parameter(Mandatory=$true)]
    [string]$mac
)

[string]$status = "info $mac" | bluetoothctl

if($status -notlike '*Missing*' -and $status -notlike '*Connected: yes*'){
    "1"
    "connect $mac" | bluetoothctl
}