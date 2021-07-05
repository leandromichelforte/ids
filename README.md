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

### Conclusão dos requisitos

Listagem [Ok]
Editar [Ok]
Atualizar [Ok]
Excluir [Ok]

## 💻 Ambiente Flutter (flutter doctor):

[√] Flutter (Channel stable, 2.2.3, on Microsoft Windows [versÃ£o 10.0.19041.1052], locale pt-BR)
[√] Android toolchain - develop for Android devices (Android SDK version 29.0.3)

## 🚀 Instalação

- Direto de um dispositivo mobile basta executar o arquivo .APK localizado em: "/build/app/outputs/flutter-apk/app-release.apk"
- De um desktop, é necessário ter o Flutter(superior à versão 2.0) instalado e configurado na máquina para que seja possível emular a aplicação.

## ☕ Utilização

A utilização do app é simples e direta com os objetivos propostos na documentação do desafio. Na landing page existe uma listagem das pessoas cadastradas, cada item da lista é identificado pelo nome e idade da pessoa. Ao pressionar o item representante da pessoa é aberto um modal na parte inferior da tela com dois ícones, editar e excluir.
A função de editar leva o usuário pra tela de mais detalhes da pessoa cadastrada, onde mostra o nome, gênero e data de nascimento, sendo possível modificá-los. Já o botão de excluir abre um diálogo para confirmação da exclusão da pessoa, informando que a ação não poderá ser desfeita.

Na tela de listagem também consta um FloatingActionButton onde leva o usuário para a tela de cadastro de uma nova pessoa.


Campos e validações:
    - Nome: TextFormField que não pode ser vazio e consta um RegExp que aceita apenas letras maíusculas, minúsculas e espaços.
    - Data de nascimento: TextFormField com DatePicker. Validação: não pode ser vazio, não pode ter uma data superior a hoje, nem dias e/ou meses inexistentes (ex: dia 42,  mês 88)
    - Gênero: DropDownFormField com as opções Masculino, Feminino e Indiferente que não pode ser vazio.

Na tela de edição/criação existem os botões "Cancelar" e "Salvar", que suas funções são: abre uma confirmação de cancelamento informando ao usuário que todas as alterações não salvas serão perdidas e valida os campos e caso tenha sucesso, salva a pessoa e retorna para a listagem.



## Observações finais

Todos os requisitos foram entregues e conforme orientação da documentação, não foi usado nenhum gestor de estado, exceto o Set State.
Foi utilizado o pacote sqflite para armazenar os dados.