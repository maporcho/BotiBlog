class Post {
  Post({
    this.id,
    this.user,
    this.message,
  });

  int id;
  User user;
  Message message;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        user: User.fromJson(json["user"]),
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user": user.toJson(),
        "message": message.toJson(),
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Post && o.id == id && o.user == user && o.message == message;
  }

  @override
  int get hashCode {
    return id.hashCode ^ user.hashCode ^ message.hashCode;
  }
}

class Message {
  Message({
    this.content,
    this.createdAt,
  });

  String content;
  DateTime createdAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "created_at": createdAt.toIso8601String(),
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Message && o.content == content && o.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return content.hashCode ^ createdAt.hashCode;
  }
}

class User {
  User({
    this.name,
    this.id,
    this.profilePicture,
  });

  String name;
  int id;
  String profilePicture;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"] == null ? null : json["id"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id == null ? null : id,
        "profile_picture": profilePicture,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.name == name &&
        o.id == id &&
        o.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return name.hashCode ^ id.hashCode ^ profilePicture.hashCode;
  }
}
