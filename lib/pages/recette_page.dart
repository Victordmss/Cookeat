import 'package:cookeat/pages/recette_data_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import 'ajout_recette_page.dart';

class Recette {
  String title;
  String presentation;
  String imageUrl;
  String description;
  Recette(this.title, this.presentation, this.imageUrl, this.description);
}

class RecettePage extends StatelessWidget {
  const RecettePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "COOK'EAT",
            style: GoogleFonts.righteous(textStyle:
              const TextStyle(fontSize: 23),fontWeight: FontWeight.bold,),),
         
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const AjoutRecettePage();
                      },
                      fullscreenDialog: true,
                    )
                );
              }
            )
          ],
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
        body: const RecetteList(),
    );
  }
}

class RecetteList extends StatefulWidget {
  const RecetteList({Key? key}) : super(key: key);

  @override
  State<RecetteList> createState() => _RecetteListState();
}

class _RecetteListState extends State<RecetteList> {
  final Stream<QuerySnapshot> _recettesStream = FirebaseFirestore.instance.collection('Recipes').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _recettesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 50,
                    width: 50,),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(
                      "Recherche de recette en cours...",
                      style: GoogleFonts.righteous(
                        textStyle: const TextStyle(fontSize: 20),)
                  )
                ],
              )
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return GestureDetector(
              onLongPress :() {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text('Supprimer ${data["nom"]} ?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          print("delete");
                          Navigator.pop(context, 'OK');

                          },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                });
                },
              onTap : () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return RecetteDataPage(data: data);
                      },
                      fullscreenDialog: true,
                    )
                );
              },
              child: Card(
                margin: const EdgeInsets.all(8),
                elevation: 8,
                child: Wrap(
                  children: [
                    Hero(
                        tag: "imageRecipe ${data['nom']}",
                        child: Image.network(data['image'], height: 100, width: 100,)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(data['nom'],
                                style:
                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          SizedBox(
                              child : Text(
                                  data['description'],
                                  style: TextStyle(color: Colors.grey[500], fontSize: 16))
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
