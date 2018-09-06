# Teste IOS da CINQ do Davi!

Olá! Neste repositório está o projeto no meu teste do app pedido.
Utilizei Realm e UserDefaults para a persistência de dados e também alguns pods para esse teste.
Para adicionar um usuário na tela inicial, foi inserido um botão com símbolo "+" à direita da Navigation Bar, e para editar/excluir um usuário, foram colcados botões nas próprias células da table view.
Foi utilizada uma tab bar para dar as opções iniciais (Início e Álbuns).

--------------------------------------          Descrição do Teste          --------------------------------------

Aqui, iremos avaliar suas capacidades técnicas referentes à vaga a qual você se candidatou.

A premissa deste teste é desenvolver um aplicativo onde seja possível realizar um cadastro de usuário, informando E-mail e Senha, e a partir deste cadastro, ser possível entrar na aplicação, realizando um processo de Autenticação.

Realizar um Fork no repositório do projeto e ao finalizar o desenvolvimento do teste enviar o link da conta onde as  alterações foram realizados.

Os requisitos mínimos/esperados para a entrega do desafio estão listados abaixo:

	1 - Desenvolver uma aplicação utilizando os seguintes padrões:
		 CoreData, Realm ou Sqllite
		 Conexão HTTP - REST
             Swift 3+ ou Objective-C
             iOS 9+
             Device Compatibility: iPhone 4s+ 
             Storyboards
		
	2 - Desenvolver uma tela onde seja possível realizar o Login, contendo os seguintes campos:
		 E-mail
		 Senha
		 Botão para Entrar
		 Link para a Tela de Cadastro
		
	3 - Desenvolver uma tela onde seja possível realizar o cadastro do usuário, persistindo na base local do APP, contendo os seguintes campos:
		 E-mail
		 Nome
		 Senha
		 Botão para Salvar
		
	4 - Desenvolver uma tela inicial, após o Login, onde seja possível visualizar as seguintes informações:
		 Nome do Usuário Logado
		 Lista de Usuários cadastrados na Aplicação
		 Possibilidade de filtrar a lista acima
		 Botão para Adicionar Novos Usuários, redirecionando para a tela do Passo 2
		 Botão para Editar Usuários, redirecionando para a tela do Passo 2
		 Botão para Excluir um Usuário, dando uma confirmação antes de realizar a ação
		
	5 - Na tela inicial, deve-se apresentar um Menu, com as opções:
		 Home
		 Lista de Albums
		
	6 - Desenvolver uma tela para a Lista de Albums, contendo os seguintes campos:
		 Utilizar um adaptar na lista, exibindo apenas o título e foto
		
Regras de Negócio
	
	1 - Na tela de Login, dar feedback de campos obrigatórios, e informar usuário sobre credenciais inválidas
	2 - Na tela de Cadastro, dar feedback de campos obrigatórios, e mensagem de sucesso quando houver tal
	3 - Na tela inicial, o campo de filtro deve ser do tipo texto, com tamanho máximo de 50 caracteres; em tempo real de digitação, a lista deve ser atualizada
	4 - Ao Editar um usuário, não deve ser possível mudar o E-mail, somente Nome e Senha
	5 - Ao Excluir um usuário, se o registro à ser excluído for o mesmo do usuário logado, deve haver um feedback impedindo a ação
	6 - Na tela de Lista de Albums, as entidades à serem exibidas deverão vir do seguinte endereço: https://jsonplaceholder.typicode.com/photos, utilizando protocolo HTTP
