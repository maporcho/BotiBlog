import 'dart:convert';

class UsuarioCadastrado {
  final int id;
  final String nome;
  final String email;
  final String senha;
  UsuarioCadastrado({
    this.id,
    this.nome,
    this.email,
    this.senha,
  });

  UsuarioCadastrado copyWith({
    int id,
    String nome,
    String email,
    String senha,
  }) {
    return UsuarioCadastrado(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }

  factory UsuarioCadastrado.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UsuarioCadastrado(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioCadastrado.fromJson(String source) =>
      UsuarioCadastrado.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsuarioCadastrado(id: $id, nome: $nome, email: $email, senha: $senha)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UsuarioCadastrado &&
        o.id == id &&
        o.nome == nome &&
        o.email == email &&
        o.senha == senha;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ email.hashCode ^ senha.hashCode;
  }
}
