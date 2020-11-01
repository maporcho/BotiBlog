import 'package:boti_blog/business/novidades/state/novidades_state.dart';
import 'package:boti_blog/business/novidades/store/novidades_store.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:boti_blog/common/ui/page_state.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/widgets/post_item.dart';
import 'package:boti_blog/ui/widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class NovidadesPage extends StatefulWidget {
  @override
  _NovidadesPageState createState() => _NovidadesPageState();
}

class _NovidadesPageState extends PageState<NovidadesPage> {
  NovidadesStore _novidadesStore;

  @override
  void initState() {
    _novidadesStore = GetIt.instance.get<NovidadesStore>();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _novidadesStore.obterNovidades();
  }

  @override
  BaseStore<BaseState> getStore() => _novidadesStore;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          Strings.novidadesTitle,
        ),
      ),
      body: SafeArea(child: Center(
        child: Observer(
          builder: (_) {
            if (_novidadesStore.state is NovidadesCarregadasComSucessoState) {
              List<Post> novidades =
                  (_novidadesStore.state as NovidadesCarregadasComSucessoState)
                      .novidades;

              return (novidades ?? []).isNotEmpty
                  ? ListView.builder(
                      itemCount: novidades.length,
                      itemBuilder: (context, index) {
                        return PostItem(
                          autor: novidades[index].user.name,
                          criadoEm: novidades[index].message.createdAt,
                          texto: novidades[index].message.content,
                          urlAvatarUsuario:
                              novidades[index].user.profilePicture,
                        );
                      },
                    )
                  : listaVazia(
                      mensagem: Strings.novidadesListaVazia,
                      onTentarNovamente: () {
                        _novidadesStore.obterNovidades();
                      },
                    );
            } else if (_novidadesStore.state is ErrorState) {
              return RetryWidget(
                message: Strings.novidadesErroAoCarregar,
                onTap: () {
                  _novidadesStore.obterNovidades();
                },
              );
            } else
              return SizedBox.shrink();
          },
        ),
      )),
    );
  }
}
