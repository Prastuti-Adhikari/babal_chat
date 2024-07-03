import 'package:babal_chat/services/alert_service.dart';
import 'package:babal_chat/services/auth_service.dart';
import 'package:babal_chat/services/navigation_service.dart';
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

  @override
void initState(){
  super.initState();
  _authService = _getIt.get<AuthService>();
  _navigationService = _getIt.get<NavigationService>();
  _alertService = _getIt.get<AlertService>();
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
      )
    );
  }
}