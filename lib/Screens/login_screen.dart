import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

import '../Requests/user_requests.dart';
import '../Screens/genres_screen.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var firstPageType = FirstPageType.login;
  bool loading = false;

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(),
            const SizedBox(height: 50),
            _buildTextField(TextFieldType.username, usernameController),
            _buildTextField(TextFieldType.password, passwordController),
            const SizedBox(height: 20),
            _buildTextButton(),
            const SizedBox(height: 40),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: firstPageType == FirstPageType.login
                  ? _buildSignInButton("Sign In")
                  : _buildSignInButton("Register"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      child: Text(
        firstPageType == FirstPageType.login ? "Register here!" : "Login here!",
        style: const TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        setState(() {
          if (firstPageType == FirstPageType.login) {
            firstPageType = FirstPageType.register;
          } else {
            firstPageType = FirstPageType.login;
          }
        });
      },
    );
  }

  Widget _buildTextField(TextFieldType textFieldType,
      TextEditingController textEditingController) {
    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: textFieldType == TextFieldType.username
              ? "Enter username"
              : "Password",
          counterText: textFieldType == TextFieldType.password &&
                  firstPageType == FirstPageType.login
              ? "Forgot password?"
              : null,
          filled: true,
          fillColor: Colors.blueGrey[50],
          labelStyle: const TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.only(left: 30),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[50]!),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[50]!),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(String text) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple[100]!,
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: ElevatedButton(
        child: Container(
            width: double.infinity,
            height: 50,
            child: !loading ? Center(child: Text(text)) : const Center(child: CircularProgressIndicator())),
        onPressed: () {
          turnLoading();
          firstPageType == FirstPageType.login ? login() : register();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 150,
      //width: 100,
      child: SvgPicture.asset("assets/images/login_page_image.svg"),
    );
  }

  void goToGenresPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      GenresScreen.routeName,
    );
  }

  Future<void> checkIfLoggedIn() async {
    final storage = FlutterSecureStorage();
    var accessToken = await storage.read(key: Constants.ACCESS_TOKEN);
    if (accessToken != null) {
      goToGenresPage(context);
    }
  }

  login() {
    UserRequests()
          .login(usernameController.text, passwordController.text)
          .onError((error, stackTrace) {
        Toast.show("Login Failed", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM,);
            turnLoading();
        return "error";
      }).then((value) {
        if (value != "error") {
          goToGenresPage(context);
        }
      });
  }

  register() {
    UserRequests()
          .register(usernameController.text, passwordController.text)
          .onError((error, stackTrace) {
        Toast.show(error.toString(), context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            turnLoading();
        return "error";
      }).then((value) {
        if (value == "complete") {
          login();
        }
      });
  }

  void turnLoading() {
    setState(() {
      loading = !loading;
    });
  }
}

enum TextFieldType { username, password }
enum FirstPageType { login, register }
