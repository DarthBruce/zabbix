[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [ValidateNotNullOrEmpty()]
  [string]$ZabbixVersion,
  [Parameter(Mandatory=$true)]
  [ValidateNotNullOrEmpty()]
  [string]$ZabbixServer,
  [Parameter(Mandatory=$true)]
  [ValidateRange(1,65535)]
  [int]$ZabbixPort
)

# Variáveis para armazenar os inputs
$ZabbixLink = "https://cdn.zabbix.com/zabbix/binaries/stable/6.2/$ZabbixVersion/zabbix_agent2-$ZabbixVersion-windows-amd64-openssl.msi"

# Realiza download do instalador
Invoke-WebRequest -Uri $ZabbixLink -OutFile "zabbix_agent.msi"

# Instala o Zabbix Agent
Start-Process msiexec.exe -Wait -ArgumentList "/i zabbix_agent.msi /qn SERVER=$ZabbixServer,PORT=$ZabbixPort"

# Remove o instalador após a instalação
#Remove-Item "zabbix_agent.msi" -Force
