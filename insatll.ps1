param(
    #MAC device
    [Parameter(Mandatory=$true)]
    [string]$mac
)

[string]$status = "info $mac" | bluetoothctl

$status

if($status -like "*not available*" -or $status -like '*Missing*'){
    throw "Device [$mac] not found."
}

Get-Content ./bluetooth-autoconnector.service | ForEach-Object{
    if($_ -like '*ps1*'){
        $_.Substring(0, $_.LastIndexOf('ps1') + 3) + " $mac"
    } 
    else
    {
        $_
    }
} | Set-Content ./bluetooth-autoconnector.service

sudo cp ./bluetooth-autoconnector.service ./bluetooth-autoconnector.timer /etc/systemd/system
sudo cp ./bluetooth-autoconnector.ps1 /usr/local/bin
sudo chmod +x /usr/local/bin/bluetooth-autoconnector.ps1

sudo systemctl daemon-reload
sudo systemctl enable bluetooth-autoconnector.timer
sudo systemctl start bluetooth-autoconnector.timer
"OK"