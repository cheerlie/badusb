# 检查当前是否具有管理员权限
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # 如果没有管理员权限，则重新启动 PowerShell 并请求提升权限
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Exit
}
# 启用远程桌面
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlset\Control\Terminal server" /v fDenyTSConnections /t REG_DWORD /d 0 /f


# 启用远程桌面防火墙规则
netsh advfirewall firewall add rule name="Remote Desktop" protocol=TCP dir=in localport=3389 action=allow

# 定义新用户的用户名和密码
$username = "RDPUser"
$password = "2021303088"

# 创建一个安全字符串的密码对象
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# 创建新的本地用户
New-LocalUser -Name $username -Password $securePassword -FullName "Remote Desktop User" -Description "User for RDP access"

# 将新用户添加到远程桌面用户组
Add-LocalGroupMember -Group "Remote Desktop Users" -Member $username
