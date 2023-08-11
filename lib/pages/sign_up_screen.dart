import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback ShowLoginPage;
  const SignUpScreen({super.key, required this.ShowLoginPage});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final namecontroller = TextEditingController();
  final dobcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final cfpasscontroller = TextEditingController();

  Future signUp() async {
    if (confirmpass()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passcontroller.text.trim());

      addUserdetail(
        namecontroller.text.trim(),
        dobcontroller.text,
        emailcontroller.text.trim(),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('MK confirm sai')));
    }
  }

  Future addUserdetail(String name, String dob, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'dob': dob,
      'email': email,
    });
  }

  bool confirmpass() {
    if (passcontroller.text.trim() == cfpasscontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _pickupDate() async {
    DateTime? _pickDT = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (_pickDT != null) {
      setState(() {
        dobcontroller.text = _pickDT.toString().split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    namecontroller.dispose();
    dobcontroller.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
    cfpasscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(color: Colors.white12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Nhap Tên...',
                    labelText: 'Họ và Tên',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                controller: dobcontroller,
                readOnly: true,
                onTap: () {
                  _pickupDate();
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Nhap ngày sinh...',
                    labelText: 'Ngày sinh',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Nhap email...',
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
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Nhap Password...',
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                controller: cfpasscontroller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Nhap lai Password...',
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: signUp, child: Text('Đăng ký')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: widget.ShowLoginPage,
                  child: Text('Login'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
