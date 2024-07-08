import 'package:babal_chat/models/message.dart';

class Chat {
  String? id;
  List<String>? participants;
  List<Message>? messages;

  Chat({
    required this.id,
    required this.participants,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as String?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((item) => Message.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'messages': messages?.map((m) => m.toJson()).toList() ?? [],
    };
  }
}
