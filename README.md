# Avaliação Flutter - IDS

# DOCUMENTAÇÃO:
Desenvolver um aplicativo para cadastro de pessoas, listando as pessoas cadastrada e
podendo editar ou remover o registro.
O aplicativo deverá ter duas telas.
• Uma tela listando as pessoas cadastradas
• Uma tela para cadastrar/editar o cadastro da pessoa selecionada na lista da tela
anterior
Observações:
1. Não é permitido utilizar pacotes para navegação de telas. Deverá ser utilizado o
navigator do Flutter.
2. Não é necessário a utilização de gerenciamento de estados. Pode utilizar o
setState.
3. Não é necessário utilizar banco de dados, sqflite por exemplo. Pode ser salvo com
o pacote SharedPreference. Porém, caso deseje utilizar não terá problema.
4. É necessário utilizar os widgets Form, DropdownButtonFormField e TextFormField
com validator na tela de cadastro de pessoas.
Estudo de caso
Ao iniciar o aplicativo, deverá conter uma lista com o nome e idade de cada pessoa
cadastrada e um FloatActionButton para cadastrar uma nova pessoa. Ao clicar no botão
de adicionar, deverá abrir uma nova janela com os seguintes campos:
• Nome completo
◦ Campo com máximo de caracteres 70.
• Data de nascimento
◦ Deverá calcular desde a data de nascimento até a data atual quantos anos a
pessoa tem.
• Sexo
◦ Um DropdownButtonFormField com as opções Masculino, Feminino,
Indiferente.
• Botão para Adicionar e um botão para Cancelar
◦ Ao clicar no botão Cancelar, deverá perguntar se deseja realmente fechar a tela
com as opções SIM e NÃO. Ao clicar em SIM, fechar a tela e voltar para a lista
de pessoas. Ao clicar em NÃO, voltar para a tela de cadastro sem nenhuma
alteração.
◦ Ao clicar no botão Adicionar, deverá ser adicionado a nova pessoa na lista.
Também deverá validar se todos os campos estão preenchidos utilizando o
validator do TextFormField antes de salvar.
Na tela com a lista de pessoas ao clicar em cima de um cadastro, deverá perguntar se
deseja Editar ou Remover o usuário. Caso clique em Editar, deverá abrir a tela de cadastro
com os campos preenchidos do usuário. Caso clique em Remover, deverá abrir uma nova
tela perguntando se realmente deseja remover o usuário com as opções SIM e NÃO. Ao
clicar em SIM, o usuário deverá ser removido da lista. Caso clique em NÃO, nada deve ser
feito.
O código deve estar em um repositório público.

