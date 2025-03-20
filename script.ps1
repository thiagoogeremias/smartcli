# Definir URL do executável e caminho de instalação
$exeUrl = "https://github.com/thiagoogeremias/smartcli/raw/refs/heads/main/smartcli.exe"  # Substitua pela URL correta
$installPath = "C:\Program Files\SmartCLI"
$exePath = "$installPath\smartcli.exe"

# Criar diretório de instalação se não existir
if (!(Test-Path $installPath)) {
    New-Item -ItemType Directory -Path $installPath -Force | Out-Null
}

# Baixar o executável
Write-Host "Baixando smartcli.exe..."
Invoke-WebRequest -Uri $exeUrl -OutFile $exePath

# Adicionar o diretório ao PATH do sistema
$envPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
if ($envPath -notlike "*$installPath*") {
    Write-Host "Adicionando $installPath ao PATH do sistema..."
    $newPath = "$envPath;$installPath"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
}

# Criar um alias para facilitar o acesso
Write-Host "Criando alias 'smartcli'..."
Set-Alias -Name smartcli -Value $exePath -Scope Global

Write-Host "Instalação concluída! Reinicie o terminal para aplicar as mudanças."
