import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(width: 3, color: Color.fromRGBO(161, 37, 67, 1))
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(width: 3, color: Color.fromRGBO(161, 37, 67, 1))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(width: 3, color: Color.fromRGBO(161, 37, 67, 1))
            ),
            hintText: "Recherchez vous quelque chose ?",
            prefixIcon: const Icon(Icons.search, size: 30,),
            suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: (){})
        ),

      ),
    );
  }
}