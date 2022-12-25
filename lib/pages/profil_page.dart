import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookeat/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Stream profilInformation = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "COOK'EAT",
            style: GoogleFonts.righteous(textStyle:
            const TextStyle(fontSize: 23),fontWeight: FontWeight.bold,),),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(184, 43, 79, 1),
          elevation: 10,
          shadowColor: Colors.indigo,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
        ),
        body: SingleChildScrollView(
          child : Center(
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: (){
                      FirebaseAuth.instance.signOut() ;
                      Navigator.push(
                          context,
                          PageRouteBuilder(pageBuilder: (_, __, ___) => const MainPage())
                      );
                    },
                    color : const Color.fromRGBO(184, 43, 79, 1),
                    child : Text(
                      "Déconnexion",
                      style: GoogleFonts.righteous(textStyle:
                      const TextStyle(fontSize: 23, color : Colors.white)
                      ),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}

