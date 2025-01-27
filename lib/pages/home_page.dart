import 'package:babal_chat/models/user_profile.dart';
import 'package:babal_chat/pages/chat_page.dart';
import 'package:babal_chat/services/alert_service.dart';
import 'package:babal_chat/services/auth_service.dart';
import 'package:babal_chat/services/database_service.dart';
import 'package:babal_chat/services/navigation_service.dart';
import 'package:babal_chat/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GetIt _getIt = GetIt.instance;

  late AuthService _authService;
  late NavigationService _navigationService; 
  late AlertService _alertService;
  late DatabaseService _databaseService;

  @override
void initState(){
  super.initState();
  _authService = _getIt.get<AuthService>();
  _navigationService = _getIt.get<NavigationService>();
  _alertService = _getIt.get<AlertService>();
  _databaseService = _getIt.get<DatabaseService>();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
        ),
        actions: [IconButton(onPressed: () async {
          bool result = await _authService.logout();
          if (result){
           _alertService.showToast(
            text: "Successfully logged out!",
            icon: Icons.check,
           );
            _navigationService.pushReplacementName("/login");
          }
        },
        color: Colors.red,
        icon: const Icon(
          Icons.logout,
        ),
        ),
        ],
      ),
      body: _buildUI(),
    );
  }

Widget _buildUI() {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      child: _chatList(),
    ),
  );
  }
  Widget _chatList() {
    return StreamBuilder(stream: _databaseService.getUserProfiles(),
    builder: (context, snapshot) {
      if (snapshot.hasError){
        return const Center(
          child: Text("Unable to load data!"),
        );
      }
      print(snapshot.data);
      if(snapshot.hasData && snapshot.data != null) {
        final users = snapshot.data!.docs;
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            UserProfile user = users[index].data();
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                ),
              child: ChatTile(userProfile: user, 
              onTap: () async {
                final chatExists = await _databaseService.checkChatExists(
                  _authService.user!.uid, 
                  user.uid!
                );
                if (!chatExists) {
                  await _databaseService.createNewChat(
                    _authService.user!.uid, 
                    user.uid!,
                  );
                }
                _navigationService.push(
                  MaterialPageRoute(builder: (context) {
                    return ChatPage(
                      chatUser: user,
                    );
                  },
                  ),       
                );
              }
              ),
            );
          },
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    );
  }
} 