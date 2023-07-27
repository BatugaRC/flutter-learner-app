import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  hintText: 'Enter your email adress',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _password,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  hintText: 'Enter the your password',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  fixedSize: const Size(130, 55),
                ),
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  String result = await _auth.signIn(email, password);
                  if (result == "0") {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      "/home/",
                      (route) => false,
                    );
                  } else {
                    print(result);
                  }
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/welcome/",
            (route) => false,
          );
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.black87,
      ),
    );
  }
}
