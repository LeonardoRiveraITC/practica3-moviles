import 'package:flutter/material.dart';
import 'package:pmsn20232/firebase/email_auth.dart';
import 'package:provider/provider.dart';
import 'package:pmsn20232/assets/global_values.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checked = false;
  final emailAuth = EmailAuth();
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPass = TextEditingController();
  final space = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      controller: txtConUser,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    final txtPass = TextField(
        controller: txtConPass,
        obscureText: true,
        decoration: const InputDecoration(border: OutlineInputBorder()));

    //   final imgLogo = Container(
    //     width: 300,
    //     decoration: const BoxDecoration(
    //       image: DecorationImage(
    //         image: NetworkImage(
    //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEAULx95mtsMi1CT2tWQldf6MfnLHGzI0nxihbieLy5jmt6H5hhSnLjaiFXjCTPZcbBx4&usqp=CAU')
    //       )
    //     ),
    //   );

    final btnEntrar = FloatingActionButton.extended(
        icon: Icon(Icons.login),
        label: Text('Entrar'),
        onPressed: () async {
          //bool res  = await  emailAuth.validateUser(emailUse: txtConUser.text,pwdUser: txtConPass.text);
          //if(res){
          //  Navigator.pushNamed(context, '/dash');
          //}
          if (checked) {
            if (txtConUser.text.isNotEmpty && txtConPass.text.isNotEmpty) {
              Provider.of<GlobalValues>(context, listen: false).setUser =
                  txtConUser.text;
              GlobalValues.saveUser(txtConUser.text, true);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Por favor, llena todos los campos")));
            }
          }
          print(GlobalValues.user);
          Navigator.pushNamed(context, '/dash');
        }
        /*(){
        Navigator.pushNamed(context, '/dash');
      }*/
        );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: .7,
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg'))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 250,
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: [
                    txtUser,
                    const SizedBox(
                      height: 10,
                    ),
                    txtPass
                  ],
                ),
              ),
              Container(
                height: 100,
                child: Column(
                  children: [
                    Checkbox(
                      value: checked,
                      onChanged: (value) {
                        setState(() {
                          checked = !checked;
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text("Registrarse"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
  }
}
