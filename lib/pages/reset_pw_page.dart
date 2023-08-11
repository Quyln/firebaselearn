import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetpassPage extends StatefulWidget {
  const ResetpassPage({super.key});

  @override
  State<ResetpassPage> createState() => _ResetpassPageState();
}

class _ResetpassPageState extends State<ResetpassPage> {
  final emailcontroller = TextEditingController();

  Future getlinkresetpass() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content:
                    Text('Successful send link reset password to your email .'),
              ));
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(e.message.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter your email to get link reset password.',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
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
          ElevatedButton(
            onPressed: getlinkresetpass,
            child: Text('Getlink'),
          )
        ],
      ),
    );
  }
}
