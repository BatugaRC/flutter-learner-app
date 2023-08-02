import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://freepngimg.com/save/166449-college-student-free-hq-image/868x1400",
            width: 150,
            height: 300,
          ),
          const Text(
            "Welcome to",
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(200, 0, 0, 0)),
          ),
          const Text(
            "Learner",
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(200, 0, 0, 0)),
          ),
          const SizedBox(
            height: 80.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  fixedSize: const Size(150.0, 75.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/signup/",
                    (route) => false,
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 31.24,
                      color: Color.fromARGB(223, 255, 255, 255)),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  fixedSize: const Size(150.0, 75.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/signin/",
                    (route) => false,
                  );
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 31.24,
                      color: Color.fromARGB(223, 255, 255, 255)),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
