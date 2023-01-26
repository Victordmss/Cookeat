import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class AjoutRecettePage extends StatefulWidget {
  const AjoutRecettePage({Key? key}) : super(key: key);

  @override
  State<AjoutRecettePage> createState() => _AjoutRecettePageState();
}

class _AjoutRecettePageState extends State<AjoutRecettePage> {

  @override
  void initState() {
    super.initState();
    _etapeCount = 1 ;
    _listEtape = [];
  }

  //Image
  File? _imageFile ;
  String? _imageURL ;
  final _picker = ImagePicker();

  Future<void> _getImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  //TextFields
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final _quantityController = TextEditingController();

  //Type Icon
  String type = "NULL" ;
  Color _iconColorBakery = const Color.fromRGBO(117, 117, 117, 1.0);
  Color _iconColorLunch = const Color.fromRGBO(117, 117, 117, 1.0);
  Color _iconColorDinner = const Color.fromRGBO(117, 117, 117, 1.0);

  //Level Icon
  int level = 0 ;
  Color _iconLevel1 = const Color.fromRGBO(117, 117, 117, 1.0);
  Color _iconLevel2 = const Color.fromRGBO(117, 117, 117, 1.0);
  Color _iconLevel3 = const Color.fromRGBO(117, 117, 117, 1.0);

  //Etapes
  List<Map<String, dynamic>> _listEtape = [];
  int _etapeCount = 1;


  listEtapeUpdate(int key, String val) {
    int foundKey = -1 ;
    for (var map in _listEtape) {
      if (map.containsKey('id')) {
        if(map['id']==key) {
          foundKey = key ;
          break ;
        }
      }
    }
    if (foundKey != -1) {
      _listEtape.removeWhere((map){
        return map['id']==foundKey ;
      });
    }
    Map<String, dynamic> json = {'id' : key, 'description' : val} ;
    _listEtape.add(json);
  }

  //Create Recipe
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _createRecipe() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    //Creation of a storage area for the image of the recipe
    if (_nameController.text.trim() == '') {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
            content: Text("Veuillez insérer un titre"));
      });
    }
    else if (_imageFile == null) {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
            content: Text("Veuillez insérer une image"));
      });
    }
    else if (_descriptionController.text.trim() == '') {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
            content: Text("Veuillez insérer une description"));
      });
    }
    else if (type == 'NULL') {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
            content: Text("Veuillez préciser un type"));
      });
    }
    else if (level == 0) {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
            content: Text("Veuillez préciser un niveau"));
      });
    }
    else {
      //Adding the recipe to the Firebase cloud
      try {
        final ref = FirebaseStorage.instance.ref()
            .child('ImagesRecettes')
            .child('$uid-${_nameController.text.trim()}.png');
        await ref.putFile(_imageFile!);
        _imageURL = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('Recipes').add(
            {
              'user': uid,
              'date': DateTime.now(),
              'nom': _nameController.text.trim(),
              'description': _descriptionController.text.trim(),
              'image': _imageURL,
              'type': type,
              'level': level,
              'duree': int.parse(_timeController.text.trim()),
              'quantite': int.parse(_quantityController.text.trim()),
              'etape': _listEtape,
            });
        showDialog(context: context, builder: (context) {
          return const AlertDialog(
              content: Text("Recette bien enregistré !"));
        });
      } on Exception {
        showDialog(context: context, builder: (context) {
          return const AlertDialog(
              content: Text(
                  "Une erreur s'est produite, votre recette ne s'est pas enregistrée :("));
        });
      }
    }

  }

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
        actions: <Widget>[
          IconButton(onPressed: () {_createRecipe();}, icon: const Icon(Icons.check)),
        ],
      ),
      body:
        SingleChildScrollView(
          child: Padding(
              padding : const EdgeInsets.all(20),
              child : Column(
                children: [
                  NameInputBox(nameController: _nameController),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    children: [
                      ImageInputBox(),
                      TypeInputBox(),
                      LevelInputBox()
                  ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  DescriptionInputBox(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 0)),
                      TimeInputBox(),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                      QuantityInputBox(),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  EtapeMenuBox(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  EtapeDynamicInputBox(),
                ],
              )
          ),
        )
      );
  }

  SizedBox EtapeDynamicInputBox() {
    return SizedBox(
                    child:
                      ListView.builder(
                          shrinkWrap:true,
                          itemCount: _etapeCount,
                          itemBuilder: (context, key) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child : TextField(
                                          onChanged: (val){
                                            listEtapeUpdate(key, val);
                                          },
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            hintText: "Etape n°${key+1}",
                                            hintStyle: const TextStyle(
                                                fontSize: 14
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(183, 43, 79, 1.0),
                                              ),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              borderSide: BorderSide(color: Color.fromRGBO(183, 43, 79, 1.0)),
                                            ),
                                          ),
                                        ),
                                    ),
                                    (key == _etapeCount - 1 && key != 0)
                                      ? IconButton(
                                        onPressed : (){
                                          if (_listEtape.isNotEmpty) {
                                          _listEtape.removeLast();}
                                          setState(() {
                                            _etapeCount--;
                                        });},
                                        icon : const Icon(Icons.delete,
                                          color: Color.fromRGBO(183, 43, 79, 1.0),
                                          size: 30,)
                                    ) : const SizedBox()
                                  ],
                                ),
                            );
                          }
                      )
                );
  }

  Row EtapeMenuBox() {
    return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left : 5),
                      child: Text("Etapes : ", style: GoogleFonts.righteous(textStyle:
                      const TextStyle(fontSize: 16)),),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 115)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _etapeCount++ ;
                          });
                        },
                        icon: const Icon(Icons.add_circle,
                          color: Color.fromRGBO(183, 43, 79, 1.0),
                          size: 30,)),
                  ],
                );
  }

  Expanded QuantityInputBox() {
    return Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _quantityController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.groups, color: Color.fromRGBO(183, 43, 79, 1.0),),
                          hintText: "Quantité (pers.)",
                          hintStyle: TextStyle(
                              fontSize: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(183, 43, 79, 1.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Color.fromRGBO(183, 43, 79, 1.0)),
                          ),
                        ),
                      ),
                    );
  }

  Expanded TimeInputBox() {
    return Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _timeController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.timer, color: Color.fromRGBO(183, 43, 79, 1.0),),
                          hintText: "Durée (min)",
                          hintStyle: TextStyle(
                              fontSize: 12
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(183, 43, 79, 1.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Color.fromRGBO(183, 43, 79, 1.0)),
                          ),
                        ),
                      ),
                    );
  }

  Row DescriptionInputBox() {
    return Row(
                  children: [
                    Expanded(
                        child: TextField(
                          maxLength: 25,
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            prefixIcon : Icon(Icons.description, color: Color.fromRGBO(183, 43, 79, 1.0),),
                            hintText: "Description",
                            hintStyle: TextStyle(
                              fontSize: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(183, 43, 79, 1.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Color.fromRGBO(183, 43, 79, 1.0)),
                            ),
                          ),
                        ),
                    )
                  ],
                );
  }

  Padding LevelInputBox() {
    return Padding(
                        padding: const EdgeInsets.only(left : 20),
                        child :
                        Column(
                          children: [
                            Text(
                              "Difficulé : ",
                              style: GoogleFonts.righteous(textStyle:
                              const TextStyle(fontSize: 16)),),
                            IconButton(
                              icon: Icon(Icons.star_border, color: _iconLevel1,),
                              onPressed: () {
                                level = 1 ;
                                setState(() {
                                  _iconLevel1 = const Color.fromRGBO(183, 43, 79, 1.0);
                                  _iconLevel2 = const Color.fromRGBO(117, 117, 117, 1.0);
                                  _iconLevel3 = const Color.fromRGBO(117, 117, 117, 1.0);
                                });
                              },
                              iconSize: 45,
                            ),
                            IconButton(
                              icon: Icon(Icons.star_half, color: _iconLevel2,),
                              onPressed: () {
                                level = 2 ;
                                setState(() {
                                  _iconLevel1 = const Color.fromRGBO(117, 117, 117, 1.0);
                                  _iconLevel2 = const Color.fromRGBO(183, 43, 79, 1.0);
                                  _iconLevel3 = const Color.fromRGBO(117, 117, 117, 1.0);
                                });
                              },
                              iconSize: 45,
                            ),
                            IconButton(
                              icon: Icon(Icons.star, color: _iconLevel3,),
                              onPressed: () {
                                level = 3 ;
                                setState(() {
                                  _iconLevel1 = const Color.fromRGBO(117, 117, 117, 1.0);
                                  _iconLevel2 = const Color.fromRGBO(117, 117, 117, 1.0);
                                  _iconLevel3 = const Color.fromRGBO(183, 43, 79, 1.0);
                                });
                              },
                              iconSize: 45,
                            ),
                          ],
                        )
                    );
  }

  Padding TypeInputBox() {
    return Padding(
                        padding: const EdgeInsets.only(left : 20),
                        child :
                        Column(
                          children: [
                            Text(
                              "Type : ",
                              style: GoogleFonts.righteous(textStyle:
                              const TextStyle(fontSize: 16)),),
                            IconButton(
                              icon: Icon(Icons.bakery_dining, color: _iconColorBakery,),
                              onPressed: () {
                                type = "Déjeuné";
                                setState(() {
                                  _iconColorBakery = const Color.fromRGBO(183, 43, 79, 1.0);
                                  _iconColorLunch = const Color.fromRGBO(117, 117, 117, 1.0);
                                  _iconColorDinner = const Color.fromRGBO(117, 117, 117, 1.0);
                                });
                              },
                              iconSize: 45,
                            ),
                            IconButton(
                              icon: Icon(Icons.lunch_dining, color: _iconColorLunch,),
                              onPressed: () {
                                type = "Déjeuné";
                                setState(() {
                                  _iconColorBakery = const Color.fromRGBO(117, 117, 117, 1.0);
                                  _iconColorLunch = const Color.fromRGBO(183, 43, 79, 1.0);
                                  _iconColorDinner = const Color.fromRGBO(117, 117, 117, 1.0);
                                });
                              },
                              iconSize: 45,
                            ),
                            IconButton(
                              icon: Icon(Icons.dinner_dining, color: _iconColorDinner,),
                              onPressed: () {
                                type = "Déjeuné";
                                setState(() {
                                  _iconColorBakery = const Color.fromRGBO(117, 117, 117, 1.0);
                                  _iconColorLunch = const Color.fromRGBO(117, 117, 117, 1.0);
                                  _iconColorDinner = const Color.fromRGBO(183, 43, 79, 1.0);
                                });
                              },
                              iconSize: 45,
                            ),
                          ],
                        )
                    );
  }

  Column ImageInputBox() {
    return Column(
                      children : [
                        Text(
                          "Image : ",
                          style: GoogleFonts.righteous(textStyle:
                          const TextStyle(fontSize: 16)),),
                        const Padding(padding: EdgeInsets.only(top : 20)),
                        GestureDetector(
                          onTap: _getImage,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color : const Color.fromRGBO(183, 43, 79, 1.0),
                                      width: 2
                                  ),),
                              width: 150,
                              height: 150,
                              child: _imageFile == null
                                  ? const Icon(Icons.image, color : Color.fromRGBO(183, 43, 79, 1.0))
                                  : Image.file(_imageFile!, fit: BoxFit.cover,)
                          ),
                        ),
                      ]
                    );
  }
}

class NameInputBox extends StatelessWidget {
  const NameInputBox({
    Key? key,
    required TextEditingController nameController,
  }) : _nameController = nameController, super(key: key);

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      textAlign: TextAlign.center,
      controller: _nameController,
      decoration: const InputDecoration(
        hintText: 'Nom de la recette',
      ),
    );
  }
}




