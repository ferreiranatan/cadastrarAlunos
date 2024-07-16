# Importa o módulo do Active Directory
Import-Module ActiveDirectory

# Caminho do arquivo CSV
$csvPath = "C:\Users\natanael.ferreira\Desktop\script_cadastro\csv\da12.csv"
$users = Import-Csv $csvPath

# Unidade Organizacional alvo, dependendo da unidade alterar o valor do valor de $targetOU
$targetOU = "OU=Alunos,DC=digitalcollegesul,DC=local"

# Loop para acessar cada usuário no CSV
foreach ($user in $users) {
    # Nome completo do usuário
    $nomeCompleto = $user.Nome
    # Primeiro nome do usuário
    $firstName = ($user.Nome -split ' ')[0]
    # CPF sem pontos e hífens
    $cpfSemFormatacao = $user.cpf -replace '\.|-', ''
    # Primeiros 4 dígitos do CPF
    $cpfUser = $cpfSemFormatacao.Substring(0, 4)
    # Nome de usuário
    $userName = ($firstName + $cpfUser)

    # Verifica se o usuário já existe, caso não exista, cria um novo usuário
    if (-not (Get-ADUser -Filter { SamAccountName -eq $userName })) {
        New-ADUser -Name $user.Nome -SamAccountName $userName `
            -UserPrincipalName ($userName + "@digitalcollegesul.local") `
            -AccountPassword (ConvertTo-SecureString -AsPlainText $cpfSemFormatacao -Force) `
            -Path $targetOU -Enabled $true -ChangePasswordAtLogon $true `
            -PasswordNeverExpires $false
        Write-Host "Usuario $nomeCompleto criado com sucesso."
    }
    else {
        # Se o usuário já existir, atualiza a senha
        $securePassword = ConvertTo-SecureString -AsPlainText $cpfSemFormatacao -Force
        Set-ADAccountPassword -Identity $userName -NewPassword $securePassword -Reset

        # Atualiza o status da conta para garantir que está habilitada e requer a troca de senha no primeiro logon
        Set-ADUser -Identity $userName `
            -Enabled $true -ChangePasswordAtLogon $true `
            -PasswordNeverExpires $false
        
        Write-Host "A senha do usuario $nomeCompleto foi alterada com sucesso."
    }
}
