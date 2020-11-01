import 'package:boti_blog/business/usuario/state/usuario_state.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:boti_blog/common/ui/boti_flat_button.dart';
import 'package:boti_blog/ui/widgets/logo_header_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/common/ui/boti_text_form_field.dart';
import 'package:boti_blog/common/ui/page_state.dart';
import 'package:boti_blog/common/ui/primary_button.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends PageState<LoginPage> {
  UsuarioStore _usuarioStore;

  String email;
  String senha;

  //controles do formulário
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  TextEditingController _emailController;

  final FocusNode _senhaFocus = FocusNode();
  TextEditingController _senhaController;

  @override
  void initState() {
    super.initState();

    _usuarioStore = GetIt.instance.get<UsuarioStore>();

    super.initState();
  }

  @override
  BaseStore<BaseState> getStore() => _usuarioStore;

  @override
  reactToState(BaseState state) {
    if (state is LoginSuccessState) {
      var router = GetIt.instance.get<PageRouter>();
      router.pushTabsPage(context);
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: BotiBlogColors.oxleyLight,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            LogoHeaderWidget(),
            SizedBox(
              height: 16,
            ),
            _formularioLogin(),
          ],
        ),
      ),
    );
  }

  Widget _formularioLogin() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BotiTextFormField(
              valueKey: ValueKey(Strings.emailKey),
              focusNode: _emailFocus,
              label: Strings.emailLabel,
              textEditingController: _emailController,
              textInputAction: TextInputAction.next,
              validator: (val) => !EmailValidator.validate(val, true)
                  ? Strings.emailInvalido
                  : null,
              onChange: (value) {
                this.email = value;
              },
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_senhaFocus),
            ),
            SizedBox(
              height: 16,
            ),
            BotiTextFormField(
              valueKey: ValueKey(Strings.senhaKey),
              focusNode: _senhaFocus,
              label: Strings.senhaLabel,
              textEditingController: _senhaController,
              textInputAction: TextInputAction.done,
              validator: (val) =>
                  (val ?? '').length < 4 ? Strings.senhaInvalida : null,
              isPassword: true,
              onFieldSubmitted: (_) {
                _validarDadosELogar();
              },
              onChange: (value) {
                this.senha = value;
              },
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: PrimaryButton(
                          title: Strings.entrarLabel,
                          onPressed: () {
                            _validarDadosELogar();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                BotiFlatButton(
                  Strings.novoCadastroLabel,
                  onPressed: () {
                    GetIt.instance.get<PageRouter>().pushCadastroPage(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _validarDadosELogar() async {
    if (_formKey.currentState.validate()) {
      _usuarioStore.efetuarLogin(email, senha);
    }
  }
}
