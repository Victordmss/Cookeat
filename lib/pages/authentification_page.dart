import 'package:cookeat/pages/home_page.dart';
import 'package:cookeat/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'change_pass.dart';


class AuthentificationPage extends StatefulWidget {
  const AuthentificationPage({Key? key}) : super(key: key);

  @override
  State<AuthentificationPage> createState() => _AuthentificationPageState();
}


class _AuthentificationPageState extends State<AuthentificationPage> {
  //TextInput Controller
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body : SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoImage(),
                const Padding(padding: EdgeInsets.only(top:10)),
                Text(
                    "Rebonjour",
                    style: GoogleFonts.righteous(
                      textStyle: const TextStyle(fontSize: 23),fontWeight: FontWeight.bold,)),
                const Text("Un petit creux ? "),
                const Padding(padding: EdgeInsets.only(top:30)),
                Padding(
                  padding : const EdgeInsets.symmetric(horizontal: 25),
                  child : TextField(
                    controller: _loginController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color : Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color : Color.fromRGBO(
                                160, 37, 67, 1.0)),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'E-mail',
                        fillColor: Colors.grey[100],
                        filled: true
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top:10)),
                Padding(
                  padding : const EdgeInsets.symmetric(horizontal: 25),
                  child : TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color : Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color : Color.fromRGBO(
                                160, 37, 67, 1.0)),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Mot de passe',
                        fillColor: Colors.grey[100],
                        filled: true
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return const ChangePassPage();}
                                )
                              );
                            },
                          child : const Text("Mot de passe oublié ?"))
                    ],
                  )
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                Padding(
                  padding : const EdgeInsets.symmetric(horizontal: 25),
                  child :
                  GestureDetector(
                    onTap: signIn,
                    child : Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomRight,
                            colors: [Color.fromRGBO(176, 56, 94, 1.0),Color.fromRGBO(141, 30, 60, 1.0)],
                          )
                      ),
                      child :
                          Center(
                            child : Text(
                                "Connexion",
                                style: GoogleFonts.righteous(textStyle:
                                const TextStyle(fontSize: 30, color : Colors.white))
                            )
                          )
                        )
                    )
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Nouveau ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) {
                                return const RegisterPage();}
                              )
                          );
                        },
                        child: const Text("Inscription"))
                  ],
                ),
              ])
          )
        )
      )
    );
  }
}


