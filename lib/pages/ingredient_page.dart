import 'package:cookeat/pages/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngredientPage extends StatelessWidget {
  const IngredientPage({Key? key}) : super(key: key);

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(pageBuilder: (_, __, ___) => const ProfilPage())
              );
            },
          ),
        ],
        elevation: 10,
        shadowColor: Colors.indigo,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
      ),
    );
  }
}
