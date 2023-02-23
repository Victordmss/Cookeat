import 'package:cookeat/pages/recette_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecetteDataPage extends StatefulWidget {
  final data ;

  RecetteDataPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<RecetteDataPage> createState() => _RecetteDataPageState();
}

class _RecetteDataPageState extends State<RecetteDataPage> {
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
                icon: const Icon(Icons.edit_note, color: Colors.white),
                onPressed: () {}
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
        body:
        SingleChildScrollView(
          child: Padding(
              padding : const EdgeInsets.all(20),
              child : Column(
                children: [
                  Text("Poulet au curry", style: GoogleFonts.righteous(textStyle: const TextStyle(fontSize: 40,color: Color.fromRGBO(160, 37, 67, 1.0)))),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left : 25),
                          child :
                          Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(183, 43, 79, 1.0),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(208, 86, 115, 1.0),
                                        offset: Offset(0, 5),
                                        blurRadius: 20,
                                        spreadRadius: -5,
                                      ),
                                    ],
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(208, 86, 115, 1.0),
                                          Color.fromRGBO(180, 53, 89, 1.0),
                                          Color.fromRGBO(140, 14, 45, 1.0),
                                          Color.fromRGBO(141, 17, 45, 1.0),
                                        ],
                                        stops: [
                                          0.1,
                                          0.45,
                                          0.99,
                                          1.0
                                        ]),
                                  ),
                                  width : 50,
                                  height: 50,
                                  child: Icon(Icons.bakery_dining, size: 45, color: Colors.white)
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                              Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(183, 43, 79, 1.0),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(208, 86, 115, 1.0),
                                        offset: Offset(0, 5),
                                        blurRadius: 20,
                                        spreadRadius: -5,
                                      ),
                                    ],
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(208, 86, 115, 1.0),
                                          Color.fromRGBO(180, 53, 89, 1.0),
                                          Color.fromRGBO(140, 14, 45, 1.0),
                                          Color.fromRGBO(141, 17, 45, 1.0),
                                        ],
                                        stops: [
                                          0.1,
                                          0.45,
                                          0.99,
                                          1.0
                                        ]),
                                  ),
                                  width : 50,
                                  height: 50,
                                  child: Icon(Icons.star_half, size: 43, color: Colors.white)
                              ),
                            ],
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left : 25),
                          child :
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(183, 43, 79, 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(208, 86, 115, 1.0),
                                      offset: Offset(0, 5),
                                      blurRadius: 20,
                                      spreadRadius: -5,
                                    ),
                                  ],
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromRGBO(208, 86, 115, 1.0),
                                        Color.fromRGBO(180, 53, 89, 1.0),
                                        Color.fromRGBO(140, 14, 45, 1.0),
                                        Color.fromRGBO(141, 17, 45, 1.0),
                                      ],
                                      stops: [
                                        0.1,
                                        0.45,
                                        0.99,
                                        1.0
                                      ]),
                                ),
                                width: 100,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.group, size : 30, color: Colors.white),
                                    Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                                    Text("3 pers.", style: GoogleFonts.righteous(textStyle: const TextStyle(fontSize: 15,color: Colors.white))),
                                  ],
                                ),
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(183, 43, 79, 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                  boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(208, 86, 115, 1.0),
                                        offset: Offset(0, 5),
                                        blurRadius: 20,
                                        spreadRadius: -5,
                                      ),
                                    ],
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromRGBO(208, 86, 115, 1.0),
                                        Color.fromRGBO(180, 53, 89, 1.0),
                                        Color.fromRGBO(140, 14, 45, 1.0),
                                        Color.fromRGBO(141, 17, 45, 1.0),
                                      ],
                                      stops: [
                                        0.1,
                                        0.45,
                                        0.99,
                                        1.0
                                      ]),
                                ),
                                width: 100,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.timer, size : 30, color: Colors.white),
                                    Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                                    Text("120 min", style: GoogleFonts.righteous(textStyle: const TextStyle(fontSize: 15,color: Colors.white))),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left : 5),
                        child: Text("Etapes : ", style: GoogleFonts.righteous(textStyle:
                        const TextStyle(fontSize: 20)),),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  //EtapeDynamicInputBox(),
                ],
              )
          ),
        )
    );
  }
}
