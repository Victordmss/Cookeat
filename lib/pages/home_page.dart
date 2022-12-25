import 'package:cookeat/pages/profil_page.dart';
import 'package:cookeat/pages/recette_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/input_widget.dart';
import 'ingredient_page.dart';



class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
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
        backgroundColor: Colors.white,
        body:
        Column(children: [
          const Padding(padding: EdgeInsets.only(top:20)),
          const LogoImage(),
          const Padding(padding: EdgeInsets.only(top:10)),
          const SearchBar(),
          const Padding(padding: EdgeInsets.only(top:30)),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                RecetteButton(),
                Padding(padding: EdgeInsets.all(20)),
                IngredientButton(),
              ]),
          const Padding(padding: EdgeInsets.only(top:50)),
          const CookitButton(),
        ])
    );
  }
}


class LogoImage extends StatelessWidget {
  const LogoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      height: 100,
      width: 100,);
  }
}


class CookitButton extends StatelessWidget {
  const CookitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 55;
    return SizedBox(
        width:340,
        child:
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(183, 51, 87, 1.0),Color.fromRGBO(141, 30, 60, 1.0)],
                )
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("COOK IT !",
                    style: GoogleFonts.righteous(textStyle: const TextStyle(fontSize: 60,fontWeight: FontWeight.bold,color: Colors.white))
                ),
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.only(left:15)),
                      IconButton(
                        icon: const Icon(Icons.bakery_dining,),
                        onPressed: () {},
                        iconSize: iconSize,
                        color:Colors.white,
                      ),
                      const Padding(padding: EdgeInsets.only(left:15, right: 15)),
                      IconButton(
                        icon: const Icon(Icons.lunch_dining),
                        onPressed: () {},
                        iconSize: iconSize,
                        color:Colors.white,
                      ),
                      const Padding(padding: EdgeInsets.only(left:15, right: 15)),
                      IconButton(
                        icon: const Icon(Icons.dinner_dining),
                        onPressed: () {},
                        iconSize: iconSize,
                        color:Colors.white,
                      ),
                      const Padding(padding: EdgeInsets.only(left:15)),
                    ],),
                ],)
              ],)
        )
    );
  }
}


class IngredientButton extends StatelessWidget {
  const IngredientButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(176, 56, 94, 1.0),Color.fromRGBO(141, 30, 60, 1.0)],
            )
        ),
        child:
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(pageBuilder: (_, __, ___) => const IngredientPage())
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("MON FRIGO",
                  style: GoogleFonts.righteous(textStyle: const TextStyle(fontSize: 20),fontWeight: FontWeight.bold,),
                ),
                const Padding(padding: EdgeInsets.only(top:10)),
                const Icon(Icons.kitchen_outlined, size:35),
              ],)
        )
    );
  }
}


class RecetteButton extends StatelessWidget {
  const RecetteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(176, 56, 94, 1.0),Color.fromRGBO(141, 30, 60, 1.0)],
            )
        ),
        child:
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(pageBuilder: (_, __, ___) => const RecettePage())
              );
            },
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("RECETTES",
                  style: GoogleFonts.righteous(textStyle: const TextStyle(fontSize: 20),fontWeight: FontWeight.bold,),
                ),
                const Padding(padding: EdgeInsets.only(top:10)),
                const Icon(Icons.dinner_dining, size:35),
              ],)
        )
    );
  }
}