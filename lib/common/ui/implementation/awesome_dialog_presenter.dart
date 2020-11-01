import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:boti_blog/common/ui/dialog_presenter.dart';
import 'package:boti_blog/ui/colors.dart';

class AwesomeDialogPresenter implements DialogPresenter {
  @override
  showWarningDialog(context,
      {String title,
      String description,
      String okButtonText,
      String cancelButtonText,
      onConfirm}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: false,
      btnOkColor: BotiBlogColors.oxleyDark,
      btnCancelColor: BotiBlogColors.vistaBlue,
      btnOkText: okButtonText,
      btnCancelText: cancelButtonText,
      animType: AnimType.SCALE,
      title: title,
      desc: description,
      btnOkOnPress: onConfirm,
      btnCancelOnPress: () {},
    )..show();
  }

  @override
  showSuccessDialog(
    context, {
    String title,
    String description,
    String okButtonText,
    onConfirm,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      headerAnimationLoop: false,
      btnOkColor: BotiBlogColors.oxleyDark,
      btnCancelColor: BotiBlogColors.vistaBlue,
      btnOkText: okButtonText ?? 'OK',
      animType: AnimType.SCALE,
      title: title,
      desc: description,
      onDissmissCallback: onConfirm,
      btnOkOnPress: onConfirm,
    )..show();
  }
}
