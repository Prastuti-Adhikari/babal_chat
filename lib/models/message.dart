import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { Text, Image }

class Message {
  String? senderID;
  String? content;
  MessageType? messageType;
  Timestamp? sentAt;

  Message({
    required this.senderID,
    required this.content,
    required this.messageType,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderID: json['senderID'] as String?,
      content: json['content'] as String?,
      sentAt: json['sentAt'] as Timestamp?,
      messageType: json['messageType'] != null 
        ? MessageType.values.firstWhere(
            (e) => e.toString() == 'MessageType.${json['messageType']}',
            orElse: () => MessageType.Text, // default to Text if no match
          )
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'content': content,
      'sentAt': sentAt,
      'messageType': messageType?.toString().split('.').last,
    };
  }
}
