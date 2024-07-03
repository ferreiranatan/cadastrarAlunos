# Script de Cadastro de Usuários no Active Directory

Este script em PowerShell foi desenvolvido para automatizar o processo de criação e atualização de usuários no Active Directory (AD) a partir de um arquivo CSV. O script verifica se o usuário já existe no AD e, se não existir, cria uma nova conta de usuário. Caso o usuário já exista, o script atualiza a senha do usuário.

## Requisitos
 
- Windows PowerShell
- Módulo Active Directory
- Acesso ao Active Directory
- Arquivo CSV contendo as informações dos alunos

## Arquivo CSV

O arquivo CSV deve conter as seguintes colunas:
- `Nome`: Nome completo do usuário
- `CPF`: CPF do usuário (sem pontos e traços)
- `Curso` : Informa o curso ou formação do aluno em questão
- `Email` : Informa o E-mail do Aluno

## Caminho do Arquivo CSV
O caminho do arquivo CSV deve ser ajustado conforme o local onde ele está armazenado:

## Unidade Organizacional (OU)
O script define a unidade organizacional (OU) onde os usuários serão criados. Este valor deve ser ajustado conforme a estrutura do seu Active Directory:

## Dependendo da Unidade Ultilizar as variáveis a seguir:
  - * UNIDADE ALDEOTA :
 $targetOU = "OU=Alunos,DC=digitalcollege,DC=local"

  - * UNIDADE SUL :
 $targetOU = "OU=Alunos,DC=digitalcollegesul,DC=local".

## Como Executar

 É necessario rodar o script *DENTRO do servidor

 - Abra o PowerShell como Administrador
 - Cole o Script e aperte enter ou acesse o local do arquivo com a extensão ".ps1" e execute com o enter 




