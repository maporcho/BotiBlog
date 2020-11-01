import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/business/usuario/state/usuario_state.dart';
import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:boti_blog/common/store/destinations_store.dart';
import 'package:boti_blog/common/ui/dialog_presenter.dart';
import 'package:boti_blog/common/ui/page_state.dart';
import 'package:boti_blog/common/ui/primary_button.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends PageState<PerfilPage> {
  UsuarioStore _usuarioStore;

  @override
  void initState() {
    _usuarioStore = GetIt.instance.get<UsuarioStore>();

    super.initState();
  }

  @override
  BaseStore<BaseState> getStore() => _usuarioStore;

  @override
  reactToState(BaseState state) {
    if (state is SaiuSuccessState) {
      var router = GetIt.instance.get<PageRouter>();
      router.pushLoginPage(context);
      GetIt.instance.get<DestinationsStore>().reset();
      _usuarioStore.resetStore();
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return FutureBuilder<Auth>(
      future: _usuarioStore.obterInfoUsuarioLogado(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _perfil(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _perfil(Auth auth) => SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetIt.instance.get<NetworkImageWidget>()
                ..imageUrl = auth.avatarUrl
                ..width = 100.0
                ..height = 100.0
                ..errorWidget = Image.asset(
                  'assets/images/logo.png',
                  height: 30.0,
                )
                ..placeholder = (context, url) => CircularProgressIndicator(),
              SizedBox(
                height: 16.0,
              ),
              Text(
                auth.nome,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16.0,
              ),
              PrimaryButton(
                title: Strings.perfilBotaoSairLabel,
                onPressed: () {
                  GetIt.instance.get<DialogPresenter>().showWarningDialog(
                    context,
                    title: Strings.perfilDialogSairTitle,
                    description: Strings.perfilDialogSairDescricao,
                    okButtonText: Strings.perfilDialogSairBotaoOkLabel,
                    cancelButtonText:
                        Strings.perfilDialogSairBotaoCancelarLabel,
                    onConfirm: () {
                      _usuarioStore.logout();
                    },
                  );
                },
              )
            ],
          ),
        ),
      );
}
