# Caminho para o arquivo CSV original
$csvPath = "C:\Users\natanael.ferreira\Desktop\script_cadastro\xml\da12.xls"
# Caminho para o novo arquivo CSV formatado
$newCsvPath = "C:\Users\natanael.ferreira\Desktop\script_cadastro"

# Ler o conteúdo do arquivo CSV
$content = Get-Content $csvPath

$formattedContent = @()

$header = $content[0]
$formattedContent += $header


for ($i = 1; $i -lt $content.Length; $i++) {
    $line = $content[$i]

    # Substituir múltiplos espaços entre os campos por uma vírgula, ignorando espaços dentro dos campos
    $fields = $line -split '\s{2,}' # Dividir onde há dois ou mais espaços
    $formattedLine = ($fields -join ',') # Juntar os campos com vírgulas

    $formattedContent += $formattedLine
}

