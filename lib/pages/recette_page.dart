import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final Stream<QuerySnapshot> _recettesStream = FirebaseFirestore.instance.collection('Recettes').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _recettesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Card(
                margin: const EdgeInsets.all(8),
                elevation: 8,
                child: Row(
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
                              width: 275,
                              child : Text(
                                  data['description'],
                                  style: TextStyle(color: Colors.grey[500], fontSize: 16))
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
          }).toList(),
        );
      },
    );
  }
}




//RecettePage SANS BDD
/*class RecettePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecettePageState();
  }
}

class RecettePageState extends State<RecettePage> {
  final List<Recette> recettes = [
    Recette(
      "Pizza facile",
      "Une bonne recette pour vos soirées foot ! ",
      "https://assets.afcdn.com/recipe/20160519/15342_w600.jpg",
      "Faire cuire dans une poêle les lardons et les champignons.\n\nDans un bol, verser la boîte de concentré de tomate, y ajouter un demi verre d'eau, ensuite mettre un carré de sucre (pour enlever l'acidité de la tomate) une pincée de sel, de poivre, et une pincée d'herbe de Provence.\n\nDérouler la pâte à pizza sur le lèche frite de votre four, piquer-le.\n\nAvec une cuillère à soupe, étaler délicatement la sauce tomate, ensuite y ajouter les lardons et les champignons bien dorer. Parsemer de fromage râpée.\n\nMettre au four à 220°, thermostat 7-8, pendant 20 min (ou lorsque le dessus de la pizza est doré).Faire cuire dans une poêle les lardons et les champignons.\n\nDans un bol, verser la boîte de concentré de tomate, y ajouter un demi verre d'eau, ensuite mettre un carré de sucre (pour enlever l'acidité de la tomate) une pincée de sel, de poivre, et une pincée d'herbe de Provence.\n\nDérouler la pâte à pizza sur le lèche frite de votre four, piquer-le.\n\nAvec une cuillère à soupe, étaler délicatement la sauce tomate, ensuite y ajouter les lardons et les champignons bien dorer. Parsemer de fromage râpée.\n\nMettre au four à 220°, thermostat 7-8, pendant 20 min (ou lorsque le dessus de la pizza est doré).",
    ),
    Recette(
        "Burger maison",
        "De quoi concurrencer le célèbre menu wooper ",
        "https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fcac.2F2018.2F09.2F25.2F03ab5e89-bad7-4a44-b952-b30c68934215.2Ejpeg/748x372/quality/90/crop-from/center/burger-maison.jpeg",
        "Pelez l’oignon rouge puis émincez-le. Rincez et essorez la roquette. Rincez la tomate puis coupez-la en rondelles.\nFaites chauffer l’huile dans une poêle et faites cuire les steaks 3 à 4 min de chaque côté, selon votre goût. En fin de cuisson, salez, poivrez, disposez 1 tranche de cheddar sur chaque steak et laissez-la légèrement fondre.\nFendez les petits pains en 2 et toastez-les légèrement. Montez les burgers : tartinez chaque moitié de pain de sauce puis garnissez avec la viande, les rondelles de tomate, l’oignon ciselé et les feuilles de roquette. Refermez les burgers et servez aussitôt.",
       ),
    Recette(
        "Crêpe comme chez nous",
        "Par Xouxou",
        "https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fcac.2F2018.2F09.2F25.2F830851b1-1f2a-4871-8676-6c06b0962938.2Ejpeg/748x372/quality/90/crop-from/center/crepes-comme-chez-nous.jpeg",
        "Versez la farine dans un grand saladier, creusez un puits. Cassez les œufs, délayez petit à petit avec le lait sans former de grumeaux. Ajoutez l’huile et le sel et mélangez bien.\nLaissez reposer la pâte 1 h sous un torchon propre à température ambiante.\nHuilez légèrement une poêle à crêpes, versez une demi-louche de pâte dans la poêle bien chaude, laissez cuire jusqu’à ce que les bords se détachent (30 sec environ). Retournez la crêpe, faites cuire l’autre face et glissez-la sur une assiette.\nProcédez ainsi pour toutes les crêpes.",
        ),
    Recette(
        "Cake nature sucré",
        "Par Huguette",
        "https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2FCAC.2Fvar.2Fcui.2Fstorage.2Fimages.2Fdossiers-gourmands.2Ftendance-cuisine.2Fles-gateaux-du-gouter-45-recettes-gourmandes-en-diaporama-187414.2F1637287-1-fre-FR.2Fles-gateaux-du-gouter-45-recettes-gourmandes-en-diaporama.2Ejpg/748x372/quality/90/crop-from/center/cake-nature-sucre.jpeg",
        "Travaillez le beurre avec le sucre en poudre.\nIncorporez les œufs, 1 par 1. Ajoutez la farine.\nVersez dans un moule à empreinte rectangulaire en silicone. Faites cuire 45 à 50 min dans le four, préchauffé à 180°C (th. 6).\nDémoulez et laissez refroidir avant de déguster.",
        ),
    Recette(
        "Donuts avec appareil à donuts",
        "Par Heud",
        "https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fcac.2F2018.2F09.2F25.2F80586d11-1f17-40ad-80ae-4cd9b5c42182.2Ejpeg/748x372/quality/90/crop-from/center/donuts-avec-appareil-a-donuts.jpeg",
        "Délayez la levure dans 2 cuil. à soupe de lait tiède. Réservez 15 min. Fouettez les œufs avec les sucres. Mélangez avec la farine et la levure. Incorporez le lait.\nLaissez la pâte reposer 1 h.\nFaites chauffer la machine et huilez les alvéoles avec un pinceau de cuisine. Versez des cuillerées de pâte dans les alvéoles de la machine chaude, en évitant de mettre de la pâte au centre. Faites cuire 2 min environ.\nFaites fondre le chocolat. Détendez-le avec un peu d'eau. Trempez-les beignets dans le chocolat. Parsemez de vermicelles. Laissez refroidir avant de déguster.",
       ),
    Recette(
        "Oreilles d'aman",
        "Par Esther",
        "https://2.bp.blogspot.com/-D9fvvQ1XyZk/WL7KSRDBe_I/AAAAAAAAhjI/udiioVWKJ20FV-P3WfW4V8TNXZDkQJ5bgCLcB/s1600/UNADJUSTEDNONRAW_thumb_3e0d.jpg",
        "Dans un saladier, battre l'œuf avec le sucre et le sucre vanillé.\nAjouter la farine et la levure et incorporer à la spatule.\nAjouter les morceaux de beurre et sabler avec les doigts comme quand on égraine la semoule.\nMalaxer ensuite avec les mains pour obtenir une boule.\nLaisser reposer 1h au frigo.",
       )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "COOK'EAT",
          style: GoogleFonts.righteous(textStyle:
          TextStyle(fontSize: 23),fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(184, 43, 79, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(pageBuilder: (_, __, ___) => ProfilPage())
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
      body: ListView.builder(
        itemCount: recettes.length,
        itemBuilder: (context, index){
          final Recette recette = recettes[index];
          return
            Dismissible(
              key: Key(recette.title),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction){
                setState(() {
                  recettes.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${recette.title} supprimé")));
              },
              background: Container(
                color: Colors.transparent,
                child:
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children:[
                        Icon(Icons.warning, color:Colors.black),
                        Text("Suppression de ${recette.title}",
                            style: GoogleFonts.righteous(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black
                                )
                            )
                        ),
                      ]
                    ),
                  )
              ),
              child: Card(
                margin: EdgeInsets.all(8),
                elevation: 8,
                child: Row(
                  children: [
                    Hero(
                      tag: "imageRecipe" + recette.title,
                      child: Image.network(recette.imageUrl, height: 100, width: 100,)
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(recette.title,
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          Container(
                            width: 275,
                            child : Text(
                              recette.presentation,
                              style: TextStyle(color: Colors.grey[500], fontSize: 16))
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
          );
        },
      ),
    );
  }
}

*/
