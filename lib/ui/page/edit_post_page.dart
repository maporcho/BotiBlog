import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/business/posts/state/posts_state.dart';
import 'package:boti_blog/business/posts/store/edit_posts_store.dart';
import 'package:boti_blog/common/business/boti_blog_params.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:boti_blog/common/ui/delete_button.dart';
import 'package:boti_blog/common/ui/dialog_presenter.dart';
import 'package:boti_blog/common/ui/page_state.dart';
import 'package:boti_blog/common/ui/primary_button.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditPostPage extends StatefulWidget {
  final Post post;

  EditPostPage({this.post});

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends PageState<EditPostPage> {
  final _formKey = GlobalKey<FormState>();

  EditPostsStore _editPostsStore;

  String texto;

  @override
  void initState() {
    _editPostsStore = GetIt.instance.get<EditPostsStore>();

    _inicializarEdicaoPost();

    super.initState();
  }

  _inicializarEdicaoPost() {
    this.texto = widget.post?.message?.content;
  }

  @override
  reactToState(BaseState state) {
    if (state is PostAdicionadoOuAlteradoComSucessoState) {
      GetIt.instance.get<PageRouter>().voltar(context, true);
      _editPostsStore.resetStore();
    }
  }

  @override
  BaseStore<BaseState> getStore() => _editPostsStore;

  @override
  Widget buildPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _cabecalho(),
                    _edicaoTexto(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cabecalho() => Row(
        children: [
          GestureDetector(
            onTap: () {
              GetIt.instance.get<PageRouter>().voltar(context);
            },
            child: Icon(Icons.close),
          ),
          Spacer(),
          if (widget.post != null)
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: DeleteButton(
                title: Strings.excluirPostLabel,
                onPressed: () {
                  GetIt.instance.get<DialogPresenter>().showWarningDialog(
                    context,
                    title: Strings.editarPostDialogConfirmacaoTitle,
                    description: Strings.editarPostDialogConfirmacaoDescricao,
                    okButtonText:
                        Strings.editarPostDialogConfirmacaoBotaoConfirmarLabel,
                    cancelButtonText:
                        Strings.editarPostDialogConfirmacaoBotaoCancelarLabel,
                    onConfirm: () {
                      _editPostsStore.removerPost(widget.post);
                    },
                  );
                },
              ),
            ),
          PrimaryButton(
            title: (widget.post == null)
                ? Strings.postarLabel
                : Strings.atualizarPostLabel,
            onPressed: () {
              _adicionarOuAtualizarPost();
            },
          ),
        ],
      );

  Widget _edicaoTexto() => Row(
        children: [
          FutureBuilder(
            future: GetIt.instance.get<UsuarioStore>().obterInfoUsuarioLogado(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final auth = (snapshot.data as Auth);
                return GetIt.instance.get<NetworkImageWidget>()
                  ..imageUrl = auth.avatarUrl
                  ..errorWidget = Image.asset(
                    'assets/images/logo.png',
                    height: 30.0,
                  )
                  ..placeholder = (context, url) => CircularProgressIndicator();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: BotiBlogParams.MAX_CHARS_POST,
                textInputAction: TextInputAction.done,
                initialValue: widget.post?.message?.content,
                decoration: InputDecoration(
                  hintText: Strings.postHintText,
                ),
                onChanged: (value) {
                  this.texto = value;
                },
                onFieldSubmitted: (_) {
                  _adicionarOuAtualizarPost();
                },
                validator: (val) {
                  if ((val ?? '').isEmpty) {
                    return Strings.postsErroVazio;
                  }

                  if ((val ?? '').length > BotiBlogParams.MAX_CHARS_POST) {
                    return Strings.postErroExcedeuTamanhoMaximo;
                  }

                  return null;
                }),
          ),
        ],
      );

  void _adicionarOuAtualizarPost() {
    if (_formKey.currentState.validate()) {
      final editPostsStore = GetIt.instance.get<EditPostsStore>();
      editPostsStore.adicionarOuAtualizarPost(
        texto,
        postAAtualizar: widget.post,
      );
    }
  }
}
