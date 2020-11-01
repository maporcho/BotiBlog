import 'package:boti_blog/common/business/boti_blog_params.dart';

class Strings {
  static const String appName = 'BotiBlog';

  //keys
  static const String emailKey = 'emailKey';
  static const String senhaKey = 'senhaKey';
  static const String nomeKey = 'nomeKey';

  //login e cadastro
  static const String nomeLabel = 'nome';
  static const String emailLabel = 'e-mail';
  static const String senhaLabel = 'senha';
  static const String entrarLabel = 'Entrar';
  static const String cadastrarLabel = 'Cadastrar';
  static const String emailInvalido = 'E-mail inválido';
  static const String senhaInvalida = 'A senha deve ter 4 ou mais caracteres';
  static const String nomeInvalido = 'O nome deve ter 3 ou mais caracteres';
  static const String erroLogin =
      'Erro ao efetuar login. Verifique o e-mail e senha informados.';
  static const String erroCadastroExistente =
      'Usuário já cadastrado. Faça seu login.';
  static const String cadastroSucessoTitulo = 'Sucesso';
  static const String cadastroSucessoTexto =
      'Cadastrado feito com sucesso! Faça seu login.';
  static const String cadastroSucessoBotaoOkLabel = 'OK';

  static const String novoCadastroLabel = 'Quero fazer parte!';
  static const String botiBlogDescription =
      'Faça parte do BotiBlog, o microblog do Boticário!';

  //novidades
  static const String novidadesTitle = 'Novidades do Boticário';
  static const String novidadesTabLabel = 'Novidades';
  static const String novidadesErroAoCarregar =
      'Erro ao carregar as novidades.';
  static const String novidadesListaVazia =
      'Sem novidades do Boticário por enquanto.';

  //posts
  static const String postsTitle = 'Posts';
  static const String postsTabLabel = 'Posts';
  static const String postsErroAoCarregar = 'Erro ao carregar as novidades.';
  static const String postsListaVazia =
      'Sem posts por enquanto! :-(\nQue tal postar algo?';

  //editar/adicionar post
  static const String postarLabel = 'Postar';
  static const String excluirPostLabel = 'Excluir';
  static const String atualizarPostLabel = 'Atualizar';
  static const String postHintText = 'Quais as novas?';
  static const String postsErroVazio = 'O texto não pode ser vazio.';
  static const String postErroExcedeuTamanhoMaximo =
      'O texto pode ter no máximo ${BotiBlogParams.MAX_CHARS_POST} caracteres.';
  static const String editarPostDialogConfirmacaoTitle = 'Excluir post';
  static const String editarPostDialogConfirmacaoDescricao =
      'Deseja excluir esse post?';
  static const String editarPostDialogConfirmacaoBotaoConfirmarLabel = 'Sim';
  static const String editarPostDialogConfirmacaoBotaoCancelarLabel = 'Não';

  //perfil

  static const String perfilTabLabel = 'Perfil';
  static const String perfilBotaoSairLabel = 'Sair';
  static const String perfilDialogSairTitle = 'Confirmação';
  static const String perfilDialogSairDescricao = 'Deseja mesmo sair?';
  static const String perfilDialogSairBotaoOkLabel = 'Sim';
  static const String perfilDialogSairBotaoCancelarLabel = 'Não';

  //Errors
  static const String erroInesperado = 'Erro inesperado.';
  static const String semConexao = 'Sem conexão.';
  static String retryText = 'Toque para tentar novamente.';
}
