import 'package:firebaselearn/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  bool showpassword = true;

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: idcontroller.text.trim(),
      password: passcontroller.text.trim(),
    );
  }

  @override
  void dispose() {
    idcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(color: Colors.white12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextFormField(
              controller: idcontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Nhap ID...',
                  labelText: 'ID',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextFormField(
              controller: passcontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  hintText: 'Nhap Password...',
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showpassword = !showpassword;
                        });
                      },
                      child: Icon(showpassword
                          ? Icons.visibility_off
                          : Icons.visibility))),
              obscureText: showpassword,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: signIn, child: Text('Login')),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text('Sign Up'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.red)),
              ),
            ],
          )
        ],
      )),
    );
  }
}
