# Caminho para o arquivo CSV
$csvPath = "C:\Users\natanael.ferreira\Desktop\script_cadastro\csv\da12.csv"


# Importa os dados do CSV
$users = Import-Csv $csvPath


foreach($user in $users){
    #Pega nome completo
    $nomeCompleto = $user.Nome
    # Pega o primeiro nome a partir do primeiro espaço
    $firstName = ($user.Nome -split ' ')[0]

    # Remove pontos e hífen do CPF
    $cpfSemFormatacao = $user.cpf -replace '\.|-', ''
    
    # Pega os primeiros quatro caracteres do CPF
    $cpfUser = $cpfSemFormatacao.substring(0, 4)
    
    # Concatena o primeiro nome com os primeiros quatro caracteres do CPF
    $userName = $firstName + $cpfUser
    
    Write-Output $nomeCompleto $userName $cpfSemFormatacao $user
}
