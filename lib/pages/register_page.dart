import 'dart:io';
import 'package:babal_chat/consts.dart';
import 'package:babal_chat/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State <RegisterPage> createState() =>  _RegisterPageState();
}

class  _RegisterPageState extends State <RegisterPage> {
  final GetIt _getIt = GetIt.instance;

  late MediaService _mediaService;

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      child: Column(
        children: [
          _headerText(),
          _registerForm(),
        ],
      ),
      ),
      );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width, 
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to Babal Chat!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Register to continue!",
              style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey
            ),
            ),
      ],
      ),
    );
  }
  Widget _registerForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height*0.60,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height*0.05,
      ),
      child: Form(
        child: Column(
          children: [
            _pfpSelectionField(),
          ],
          ),
      ),
    );
  }

  Widget _pfpSelectionField() {
    return GestureDetector(
      onTap: () async {
        File? file = await MediaService.getImageFromGallery();
        if(file != null) {
          setState((){
            selectedImage =file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width*0.15,
        backgroundImage: selectedImage != null ? FileImage(selectedImage!) : NetworkImage(PLACEHOLDER_PFP) as ImageProvider,
      ),
    );
  }
}