import 'package:firebaselearn/pages/reset_pw_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  bool showpassword = true;

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passcontroller.text.trim(),
    );
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

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
              controller: emailcontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Nhap Email...',
                  labelText: 'Email',
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
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetpassPage()));
                  },
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: signIn, child: Text('Login')),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: widget.showRegisterPage,
                child: Text('Sign Up'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.red)),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     GestureDetector(
          //       onTap: signInWithGoogle,
          //       child: Container(
          //         padding: EdgeInsets.all(10),
          //         decoration: BoxDecoration(
          //             color: Colors.blue,
          //             borderRadius: BorderRadius.circular(20)),
          //         height: 40,
          //         width: 200,
          //         child: Row(
          //           children: [Icon(Icons.mail), Text('SignIn with google')],
          //         ),
          //       ),
          //     )
          //   ],
          // )
        ],
      )),
    );
  }
}
