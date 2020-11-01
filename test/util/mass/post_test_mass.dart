import 'package:boti_blog/common/model/post.dart';

final userDeTeste1 = User(
  id: 1,
  name: 'Fulano',
  profilePicture: 'http://um.endereco.qualquer/1.jpg',
);

final userDeTeste2 = User(
  id: 2,
  name: 'Beltrano',
  profilePicture: 'http://um.endereco.qualquer/2.jpg',
);

final postDeTeste1 = Post(
  id: 1,
  message: Message(
    content: 'Mensagem de teste 1',
    createdAt: DateTime.parse('2020-08-02T16:10:33Z'),
  ),
  user: userDeTeste1,
);

final postDeTeste2 = Post(
  id: 2,
  message: Message(
    content: 'Mensagem de teste 2',
    createdAt: DateTime.parse('2020-08-04T16:10:33Z'),
  ),
  user: userDeTeste1,
);

final postDeTeste3 = Post(
  id: 2,
  message: Message(
    content: 'Mensagem de teste 3',
    createdAt: DateTime.parse('2020-08-05T16:10:33Z'),
  ),
  user: userDeTeste2,
);

final postsDeTeste = [
  postDeTeste1,
  postDeTeste2,
  postDeTeste3,
];
