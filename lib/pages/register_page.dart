import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookeat/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _secondpasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _ageController = TextEditingController();

  Future signUp() async {
    if (_passwordController.text.trim() == _secondpasswordController.text.trim()) {
      try {
        //Register new user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        //Add user informations
        await addUserInformation();
        showDialog(context: context, builder: (context) {
          return const AlertDialog(
              content: Text("C'est fait ! Vous pouvez quitter la page pour rejoindre l'application ! ;)"));
        });
      }on FirebaseAuthException {
        showDialog(context: context, builder: (context) {
          return const AlertDialog(
              content: Text("Oups, une erreur s'est produite :("));
        });
      }
    }
    else {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
            content: Text("Erreur, vos deux mots de passes sont différents"));
      });
    }
  }

  Future<void> addUserInformation() async {
    await FirebaseFirestore.instance.collection('Users').add(
      {
        'email' : _emailController.text.trim(),
        'first name' : _surnameController.text.trim(),
        'name' : _nameController.text.trim(),
        'age' : int.parse(_ageController.text.trim()),
      }
    );
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _secondpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(184, 43, 79, 1),
          shadowColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
        ),
        backgroundColor: Colors.white,
        body : SafeArea(
            child: SingleChildScrollView(
                  child : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                        children: [
                          const LogoImage(),
                          const Padding(padding: EdgeInsets.only(top:10)),
                          Text(
                              "Bonjour",
                              style: GoogleFonts.righteous(
                                textStyle: const TextStyle(fontSize: 23),fontWeight: FontWeight.bold,)),
                          const Text("Ravi de vous rencontrer "),
                          const Padding(padding: EdgeInsets.only(top:30)),
                          Padding(
                            padding : const EdgeInsets.symmetric(horizontal: 25),
                            child : TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color : Colors.black),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color : Color.fromRGBO(
                                          160, 37, 67, 1.0)),
                                      borderRadius: BorderRadius.circular(12)),
                                  hintText: 'Nom',
                                  fillColor: Colors.grey[100],
                                  filled: true
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top:10)),
                          Padding(
                            padding : const EdgeInsets.symmetric(horizontal: 25),
                            child : TextField(
                              controller: _surnameController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color : Colors.black),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color : Color.fromRGBO(
                                          160, 37, 67, 1.0)),
                                      borderRadius: BorderRadius.circular(12)),
                                  hintText: 'Prenom',
                                  fillColor: Colors.grey[100],
                                  filled: true
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top:10)),
                          Padding(
                            padding : const EdgeInsets.symmetric(horizontal: 25),
                            child : TextField(
                              controller: _ageController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color : Colors.black),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color : Color.fromRGBO(
                                          160, 37, 67, 1.0)),
                                      borderRadius: BorderRadius.circular(12)),
                                  hintText: 'Age',
                                  fillColor: Colors.grey[100],
                                  filled: true
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top:10)),
                          Padding(
                            padding : const EdgeInsets.symmetric(horizontal: 25),
                            child : TextField(
                              controller: _emailController,
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
                          const Padding(padding: EdgeInsets.only(top:10)),
                          Padding(
                            padding : const EdgeInsets.symmetric(horizontal: 25),
                            child : TextField(
                              controller: _secondpasswordController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color : Colors.black),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color : Color.fromRGBO(
                                          160, 37, 67, 1.0)),
                                      borderRadius: BorderRadius.circular(12)),
                                  hintText: 'Confirmer le mot de passe',
                                  fillColor: Colors.grey[100],
                                  filled: true
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 15)),
                          Padding(
                              padding : const EdgeInsets.symmetric(horizontal: 25),
                              child :
                              GestureDetector(
                                  onTap: signUp,
                                  child : Container(
                                      height: 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomRight,
                                            colors: [Color.fromRGBO(176, 56, 94, 1.0),Color.fromRGBO(141, 30, 60, 1.0)],
                                          )
                                      ),
                                      child :
                                      Center(
                                          child : Text(
                                              "Inscription",
                                              style: GoogleFonts.righteous(textStyle:
                                              const TextStyle(fontSize: 30, color : Colors.white))
                                          )
                                      )
                                  )
                              )
                          ),
                        ])
                  )
            )
        )
    );
  }
}


