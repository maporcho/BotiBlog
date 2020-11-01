import 'package:boti_blog/business/usuario/model/auth.dart';

final authDeTeste = Auth(
  id: 1,
  nome: 'Usuário de teste',
  token: 'token.de.teste',
  avatarUrl: 'https://uma.url.qualquer/1.jpg',
);

final authJsonDeTeste = authDeTeste.toJson();
