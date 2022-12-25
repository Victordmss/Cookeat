import 'package:cookeat/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {

  final _emailController = TextEditingController();


  Future resetPass() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim()
      );
      showDialog(context: context, builder: (context) {
        return const AlertDialog(content: Text("C'est fait ! Vérifiez votre boite mail ;)"));
      }
      );
    } on FirebaseAuthException {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(content: Text("Oups, une erreur s'est produite :("));
      }
      );
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(184, 43, 79, 1),
          shadowColor: Colors.indigo,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
        ),
        backgroundColor: Colors.white,
        body :
        Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child : Column(
              children: [
                const Padding(padding: EdgeInsets.all(40)),
                const LogoImage(),
                const Padding(padding: EdgeInsets.only(top:10)),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                    "No problemo,",
                    style: GoogleFonts.righteous(
                      textStyle: const TextStyle(fontSize: 23),fontWeight: FontWeight.bold,)),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Text("Précisez nous votre email, vous recevrez un lien pour changer votre mot de passe",
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                Padding(
                  padding : const EdgeInsets.symmetric(horizontal: 15),
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
                const Padding(padding: EdgeInsets.only(top: 20)),
                Padding(
                    padding : const EdgeInsets.symmetric(horizontal: 25),
                    child :
                    GestureDetector(
                        onTap: resetPass,
                        child : Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomRight,
                                  colors: [Color.fromRGBO(176, 56, 94, 1.0),Color.fromRGBO(141, 30, 60, 1.0)],
                                )
                            ),
                            child :
                            Center(
                                child : Text(
                                    "Envoyer",
                                    style: GoogleFonts.righteous(textStyle:
                                    const TextStyle(fontSize: 30, color : Colors.white))
                                )
                            )
                        )
                    )
                ),
              ],
            )
        )
    );
  }
}