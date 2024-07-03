import 'dart:io';
import 'package:babal_chat/consts.dart';
import 'package:babal_chat/services/media_service.dart';
import 'package:babal_chat/services/navigation_service.dart';
import 'package:babal_chat/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State <RegisterPage> createState() =>  _RegisterPageState();
}

class  _RegisterPageState extends State <RegisterPage> {
  final GetIt _getIt = GetIt.instance;

  late MediaService _mediaService;
  late NavigationService _navigationService;

  String? email, password, name;

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _navigationService = _getIt.get<NavigationService>();
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
          _loginAccountLink(),
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
          mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pfpSelectionField(),
            CustomFormField(
              hintText: "Name",
              height: MediaQuery.sizeOf(context).height*0.1,
              validationRegEx: NAME_VALIDATION_REGEX,
              onSaved: (value) {
                setState((){
                  name = value; 
                },
                );
              },
              ),
               CustomFormField(
              hintText: "Email",
              height: MediaQuery.sizeOf(context).height*0.1,
              validationRegEx: EMAIL_VALIDATION_REGEX,
              onSaved: (value) {
                setState((){
                  email = value; 
                },
                );
              },
              ),
               CustomFormField(
              hintText: "Password",
              height: MediaQuery.sizeOf(context).height*0.1,
              validationRegEx: PASSWORD_VALIDATION_REGEX,
              onSaved: (value) {
                setState((){
                  password = value; 
                },
                );
              },
              ),
              _registerButton(),
          ],
          ),
      ),
    );
  }

  Widget _pfpSelectionField() {
    return GestureDetector(
      onTap: () async {
        File? file = await _mediaService.getImageFromGallery();
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
    
    Widget _registerButton(){
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {},
          child: const Text (
            "Register",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
        );
    }
     Widget _loginAccountLink() {
      return Expanded( child: Row(
         mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
        children: [
         const Text("Already have an account?"),
         GestureDetector(
          onTap: () {
            _navigationService.goBack();
          },
           child: const Text(
            "Log in",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
                   ),
         ),
        ],
      ));
    }
  }