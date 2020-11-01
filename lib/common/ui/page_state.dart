import 'package:boti_blog/common/infrastructure/logger.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/state/loading_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:boti_blog/ui/colors.dart';
import 'package:boti_blog/ui/widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobx/mobx.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'alerter.dart';

abstract class PageState<T extends StatefulWidget> extends State<T> {
  ReactionDisposer _stateReactionDisposer;

  bool _loading = false;

  Logger logger;

  //sem essa linha, não consigo referenciar o widget a partir das subclasses
  T get widget => super.widget;

  @override
  void initState() {
    super.initState();

    logger = GetIt.instance.get<Logger>();

    initializeDateFormatting();

    _initReactionDisposer();
  }

  void _initReactionDisposer() {
    _stateReactionDisposer = autorun((_) {
      var state = getStore().state;

      isLoading(state is LoadingState);

      if (state is ErrorState) {
        handleErrorState(state);
      } else {
        reactToState(state);
      }
    });
  }

  BaseStore getStore();

  reactToState(BaseState state) {}

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: buildPage(context),
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          BotiBlogColors.oxleyDark,
        ),
      ),
      opacity: 0.9,
      color: Colors.white,
    );
  }

  Widget buildPage(BuildContext context);

  isLoading(bool isLoading) {
    if (isLoading) {
      _hideKeyboard();
    }
    safeSetState(() {
      this._loading = isLoading;
    });
  }

  _hideKeyboard() {
    try {
      FocusManager.instance.primaryFocus.unfocus();
    } catch (e) {
      logger?.logError(e.toString(), this.runtimeType);
    }
  }

  safeSetState(VoidCallback lambda) {
    if (mounted) {
      setState(() {
        lambda();
      });
    }
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    FocusScope.of(context).nextFocus();
  }

  handleErrorState(ErrorState state) {
    final alerter = GetIt.instance.get<Alerter>();
    alerter.showErrorAlert(
      context,
      message: state.toString(),
    );
    logger.logError(
      state.toString(),
      this.runtimeType,
    );
  }

  Widget listaVazia({
    String mensagem,
    VoidCallback onTentarNovamente,
  }) =>
      RetryWidget(
        message: mensagem,
        onTap: onTentarNovamente,
      );

  @override
  void dispose() {
    _disposeReactionDisposer();

    super.dispose();
  }

  void _disposeReactionDisposer() {
    if (_stateReactionDisposer != null) _stateReactionDisposer();
  }
}
