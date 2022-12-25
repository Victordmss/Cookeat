import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class AjoutRecettePage extends StatefulWidget {
  const AjoutRecettePage({Key? key}) : super(key: key);

  @override
  State<AjoutRecettePage> createState() => _AjoutRecettePageState();
}

class _AjoutRecettePageState extends State<AjoutRecettePage> {
  final imageController = TextEditingController();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ajouter une recette",
          style: GoogleFonts.righteous(textStyle:
          const TextStyle(fontSize: 23)),),
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Color.fromRGBO(184, 43, 79, 1), width: 1.5),
              ),
              title: Row(
                children: [
                  const Text('Image : '),
                  Expanded(child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: imageController,
                  ))
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top:20)),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Color.fromRGBO(184, 43, 79, 1), width: 1.5),
              ),
              title: Row(
                children: [
                  const Text('Titre : '),
                  Expanded(child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  controller: nameController,
                  ))
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top:20)),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Color.fromRGBO(184, 43, 79, 1), width: 1.5),
              ),
              title: Row(
                children: [
                  const Text('Type : '),
                  Expanded(child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: typeController,
                  ))
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top:20)),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Color.fromRGBO(184, 43, 79, 1), width: 1.5),
              ),
              title: Row(
                children: [
                  const Text('Description : '),
                  Expanded(child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: descriptionController,
                  ))
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}

