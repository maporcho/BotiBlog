# BotiBlog

O microblog do Boticário: veja nossas novidades e compartilhe as suas!

![BotiBlog screenshots](/docs/screenshots.png)

## Utilizando o app

Para utilizar o BotiBlog, siga os passos abaixo:

1. No diretório do projeto, rode `flutter run` após conectar um dispositivo ou rodar um emulador/simulador. Alternativamente, instale o arquivo [/dist/boti_blog.apk](/dist/boti_blog.apk) e execute o app em um dispositivo Android.

2. Na tela que será exibida após a splashscreen, cadastre um novo usuário tocando em _"Quero fazer parte!"_ ou forneça os dados do usuário pré-cadastrado:

_e-mail_: teste@teste.com

_senha_: 1234

## A arquitetura da solução

O app foi construído valendo-se de uma arquitetura em camadas, baseada em interfaces. Dessa forma, as dependências entre classes são expressas em termos de interfaces (na verdade, classes abstratas do Dart), ao invés das implementações concretas. Essas implementações são injetadas em um ponto específico do app (vide main.dart), o que facilita sua substituição sem que seja necessário alterar outras partes do código - e também auxilia muito na elaboração de testes unitários.

O gerenciamento de estado nas telas utiliza MobX. As Pages (widgets que estão no topo da hierarquia de UI) são controladas por estados; alterações de estado fazem com que a tela seja alterada de acordo (deixando de exibir um indicativo de carregamento de lista e passando a exibir a lista de novidades, por exemplo).

O código seguiu os princípios SOLID, com o objetivo de tornar a solução flexível e facilitar sua manutenção.

### Estrutura do código

O código-fonte em /lib está organizado da seguinte forma:

- /business/\<_funcionalidade_\>: lógica de negócio e classes relacionadas a uma funcionalidade específica

  - /model: os modelos utilizados na funcionalidade;
  - /state: os estados envolvidos na funcionalidade (sucesso, erro etc);
  - /store: as stores do MobX que lidam com lógica de negócio.

- /common: classes utilizadas em múltiplas funcionalidades

- /infrastructure: classes de fronteira, responsáveis por interagir com recursos externos (nesse desafio, responsáveis pela obtenção das novidades, obtenção e gerenciamento de posts)

- /ui: classes relacionadas à interface com o usuário (UI)
  - /pages: as telas (Pages) do app;
  - /widgets: os widgets que compõe as pages.

Algumas classes são abstratas e suas implementações concretas estão no sub-pacote "implementation", no diretório que as contêm.

### Minimizando dependência com bibliotecas

A solução foi construída de modo a centralizar, em poucas classes, a dependência com bibliotecas externas.

Um exemplo é o próprio MobX, presente apenas nas Stores e na superclasse utilizada no estado das páginas (PageState).

## Testes unitários

A arquitetura foi pensada de modo a facilitar a elaboração de testes unitários. Desse modo, foi possível elaborar testes para as principais classes envolvidas na solução, inclusive aquelas responsáveis pela interface com o usuário.

Os testes unitários estão no diretório /test. A estrutura desse diretório é similar à encontrada em /lib.

Em /test/util, estão presentes objetos e classes utilizados em todos os testes para:

- injeção de dependências
- criação de dublês de teste (mocks e stubs)
- massa de teste

Os testes unitários podem ser executados rodando `flutter test` no diretório do projeto.
