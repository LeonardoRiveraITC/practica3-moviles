import 'package:flutter/material.dart';
import 'package:pmsn20232/firebase/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conNameUser  = TextEditingController();

  final conEmailUser  = TextEditingController();

  final conPwdUser  = TextEditingController();

  final emailAuth =EmailAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text('Register a user')),
      body: Column(
        children: [
          TextFormField(controller:conNameUser),
          TextFormField(controller: conEmailUser),
          TextFormField(controller:conPwdUser),
          ElevatedButton(onPressed: (){emailAuth.createUser(emailUser: conEmailUser.text, pwdUser: conPwdUser.text);}, child: Text('Save user'))
        ],
      ),
    );
  }
}