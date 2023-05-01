

class Chat {
  String? id;
  String? user_id;
  String? message;

  Chat({
    this.id,
    required this.user_id,
    required this.message,

  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        id: json['_id'],
        user_id: json['user_id'],
        message: json['message'],

    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'message': message,
    };
  }

}
