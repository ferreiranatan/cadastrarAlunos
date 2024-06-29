# Caminho para o arquivo CSV
$csvPath = "C:\Users\natanael.ferreira\Desktop\script_cadastro\list\gt01.csv"


# Importa os dados do CSV
$users = Import-Csv $csvPath

# HashSet para rastrear nomes de usuário únicos
$userNames = New-Object System.Collections.Generic.HashSet[System.String]

foreach($user in $users){
    #Pega nome completo
    $nomeCompleto = $user.nome
    # Pega o primeiro nome (assumindo que os nomes são separados por espaço)
    $firstName = ($user.nome -split ' ')[0]

    # Remove pontos e hífen do CPF
    $cpfSemFormatacao = $user.cpf -replace '\.|-', ''
    
    # Pega os primeiros quatro caracteres do CPF
    $cpfUser = $cpfSemFormatacao.Substring(0, 4)
    
    # Concatena o primeiro nome com os primeiros quatro caracteres do CPF
    $userName = $firstName + $cpfUser
    
    # Tenta adicionar o nome de usuário ao HashSet
    if ($userNames.Add($userName)) {
        # Se for adicionado com sucesso, imprime ou usa o $userName conforme necessário
        Write-Output $nomeCompleto $userName $cpfSemFormatacao $user
    }
}
