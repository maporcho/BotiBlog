import 'dart:convert';

class Auth {
  static const String KEY = 'Auth';

  String token;
  int id;
  String nome;
  String avatarUrl;

  Auth({
    this.token,
    this.id,
    this.nome,
    this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'id': id,
      'nome': nome,
      'avatarUrl': avatarUrl,
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Auth(
      token: map['token'],
      id: map['id'],
      nome: map['nome'],
      avatarUrl: map['avatarUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) => Auth.fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Auth &&
        o.id == id &&
        o.token == token &&
        o.nome == nome &&
        o.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ token.hashCode ^ nome.hashCode ^ avatarUrl.hashCode;
  }
}
