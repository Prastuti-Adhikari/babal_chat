import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:babal_chat/consts.dart';
import 'package:babal_chat/models/user_profile.dart';
import 'package:babal_chat/services/alert_service.dart';
import 'package:babal_chat/services/auth_service.dart';
import 'package:babal_chat/services/database_service.dart';
import 'package:babal_chat/services/media_service.dart';
import 'package:babal_chat/services/navigation_service.dart';
import 'package:babal_chat/services/storage_services.dart';
import 'package:babal_chat/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _registerFormKey = GlobalKey();

  late AuthService _authService;
  late MediaService _mediaService;
  late NavigationService _navigationService;
  late StorageService _storageService;
  late AlertService _alertService;
  late DatabaseService _databaseService;

  String? email, password, name;

  File? selectedImage;
  Uint8List? webImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _alertService = _getIt.get<AlertService>();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _storageService = _getIt.get<StorageService>();
    _databaseService = _getIt.get<DatabaseService>();
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
            if (!isLoading) _registerForm(),
            if (!isLoading) _loginAccountLink(),
            if (isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
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
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.60,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.05,
      ),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pfpSelectionField(),
            CustomFormField(
              hintText: "Name",
              height: MediaQuery.sizeOf(context).height * 0.1,
              validationRegEx: NAME_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            CustomFormField(
              hintText: "Email",
              height: MediaQuery.sizeOf(context).height * 0.1,
              validationRegEx: EMAIL_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            CustomFormField(
              hintText: "Password",
              height: MediaQuery.sizeOf(context).height * 0.1,
              validationRegEx: PASSWORD_VALIDATION_REGEX,
              obscureText: true,
              onSaved: (value) {
                setState(() {
                  password = value;
                });
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
        final image = await _mediaService.getImageFromGallery();
        if (image != null) {
          setState(() {
            if (kIsWeb) {
              webImage = image as Uint8List;
            } else {
              selectedImage = image as File;
            }
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : webImage != null
                ? MemoryImage(webImage!)
                : NetworkImage(PLACEHOLDER_PFP) as ImageProvider,
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.primary,
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
  if ((_registerFormKey.currentState?.validate() ?? false)) {
    _registerFormKey.currentState?.save();
    bool result = await _authService.signup(email!, password!);
    if (result) {
      String? pfpURL;
      if (kIsWeb && webImage != null) {
        pfpURL = await _storageService.uploadUserPfp(
          bytes: webImage!,
          uid: _authService.user!.uid,
        );
      } else if (selectedImage != null) {
        pfpURL = await _storageService.uploadUserPfp(
          file: selectedImage!,
          uid: _authService.user!.uid,
        );
      }

      if (pfpURL != null) {
        await _databaseService.createUserProfile(
          userProfile: UserProfile(
            uid: _authService.user!.uid,
            name: name,
            pfpURL: pfpURL,
          ),
        );
        _alertService.showToast(
          text: "Account created successfully!",
          icon: Icons.check,
        );
        _navigationService.goBack();
        _navigationService.pushReplacementName("/home");
      } else {
        throw Exception("Unable to upload profile picture!");
      }
    } else {
      throw Exception("Failed to register user");
    }
  }
} catch (e) {
  print(e);
  _alertService.showToast(
    text: "Failed to register, Please try again!",
    icon: Icons.error,
  );
} finally {
  setState(() {
    isLoading = false;
  });
}
        },
        child: const Text(
          "Register",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _loginAccountLink() {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "Already have an account?",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () {
              _navigationService.goBack();
              _navigationService.pushReplacementName("/login");
            },
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
