import 'package:babal_chat/models/user_profile.dart';
import 'package:babal_chat/services/auth_service.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatPage extends StatefulWidget {
  final UserProfile chatUser;

  const ChatPage({
    super.key,
    required this.chatUser,
    });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  ChatUser? currentUser, otherUser;
  
  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    currentUser = ChatUser(
      id: _authService.user!.uid,
      firstName: _authService.user!.displayName,
    );
    otherUser = ChatUser(
      id: widget.chatUser.uid!,
      firstName: widget.chatUser.name!,
      profileImage: widget.chatUser.pfpURL,
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.chatUser.name!
          ),
        ),
        body: _buildUI(),
    );
  }

  Widget _buildUI(){
    return DashChat(
      currentUser: currentUser!,
      onSend: (message) {}, 
      messages: [],
      );
  }
}