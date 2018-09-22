#!/usr/bin/pwsh-preview

param(
    [Parameter(Mandatory=$true)]
    [string]$mac
)

[string]$status = "info" | bluetoothctl

if($status -notlike '*Connected: yes*'){
    "connect $mac" | bluetoothctl
}