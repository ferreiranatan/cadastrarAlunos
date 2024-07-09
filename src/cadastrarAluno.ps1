# Importa o módulo do Active Directory
Import-Module ActiveDirectory

# Caminho do arquivo CSV
$csvPath = "..\csv\da12.csv"

$users = Import-Csv $csvPath

# Unidade Organizacional alvo, dependendo da unidade alterar o valor do valor de $targetOU
$targetOU = "OU=Alunos,DC=digitalcollegesul,DC=local"

# Loop para acessar cada usuário no CSV
foreach($user in $users) {
    # Nome completo do usuário
    $nomeCompleto = $user.nome
    # Primeiro nome do usuário
    $firstName = ($user.Nome -split ' ')[0]
    # CPF sem pontos
    $cpfSemPonto = $user.CPF -replace '\.', ''
    # Primeiros 4 dígitos do CPF
    $cpfUser = $cpfSemPonto.Substring(0,4)
    # Nome de usuário
    $userName = ($firstName + $cpfUser)

    # Verifica se o usuário já existe caso não exista, cria um novo usuário
    if (-not (Get-ADUser -Filter {SamAccountName -eq $userName})) {
        New-ADUser -Name $user.Nome -SamAccountName $userName `
        -UserPrincipalName ($userName + "@digitalcollegesul.local") `
        -AccountPassword (ConvertTo-SecureString -AsPlainText $cpfSemPonto -Force) `
        -Path $targetOU -Enabled $true -ChangePasswordAtLogon $true `
        -PasswordNeverExpires $false
        Write-Host "Usuario $nomeCompleto criado com sucesso."
    } else {
        # se o usuário já existir, atualiza a senha
        $securePassword = ConvertTo-SecureString -AsPlainText $cpfSemPonto -Force
        Set-ADAccountPassword -Identity $userName -AccountPassword $securePassword -Reset
        Write-Host "Usuario $nomeCompleto já existe, a senha foi atualizada."
       
}
}