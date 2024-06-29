# Importa o módulo do Active Directory
Import-Module ActiveDirectory

# Caminho do arquivo CSV
$csvPath = "C:\Users\natanael.ferreira\Desktop\script_cadastro\cadastrarUsuarios\gt02.csv"
$users = Import-Csv $csvPath

# Unidade Organizacional alvo
$targetOU = "OU=Alunos,DC=digitalcollegesul,DC=local"

# Loop para processar cada usuário no CSV
foreach($user in $users) {
    # Primeira parte do nome
    $firstName = ($user.Nome -split ' ')[0]
    # CPF sem pontos
    $cpfSemPonto = $user.CPF -replace '\.', ''
    # Primeiros 4 dígitos do CPF
    $cpfUser = $cpfSemPonto.Substring(0,4)
    # Nome de usuário
    $userName = ($firstName + $cpfUser)

    # Verifica se o usuário já existe
    if (-not (Get-ADUser -Filter {SamAccountName -eq $userName})) {
        # Cria um novo usuário
        New-ADUser -Name ($user.Nome) -SamAccountName ($userName) `
                   -UserPrincipalName ($userName + "@digitalcollegesul.local") `
                   -NewPassword (ConvertTo-SecureString -AsPlainText $user.CPF -Force) `
                   -Path $targetOU -Enabled $true
        Write-Host "Usuário $userName criado com sucesso."
    } else {
        # Atualiza a senha do usuário existente
        $securePassword = ConvertTo-SecureString -AsPlainText $user.CPF -Force
        Set-ADAccountPassword -Identity $userName -NewPassword $securePassword -Reset
        Write-Host "Usuário $userName já existe, senha atualizada."
    }
}
