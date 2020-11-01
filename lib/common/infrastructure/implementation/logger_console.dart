import 'package:boti_blog/common/infrastructure/logger.dart';
import 'package:intl/intl.dart';

class LoggerConsole extends Logger {
  @override
  void logError(mensagem, Type caller) {
    String mensagemFormatada = _formatMessage("ERROR", mensagem, caller);
    print(mensagemFormatada);
  }

  @override
  void logInfo(mensagem, Type caller) {
    String mensagemFormatada = _formatMessage("INFO", mensagem, caller);
    print(mensagemFormatada);
  }

  @override
  void logDebug(mensagem, Type caller) {
    String mensagemFormatada = _formatMessage("DEBUG", mensagem, caller);
    print(mensagemFormatada);
  }

  String _timeFormatted() {
    DateFormat dateFormat = DateFormat("HH:mm:ss");
    return dateFormat.format(DateTime.now());
  }

  String _formatMessage(String errorTypeDescription, message, Type caller) {
    return _timeFormatted() +
        " ($errorTypeDescription): " +
        caller?.toString() +
        " - " +
        message?.toString();
  }
}
