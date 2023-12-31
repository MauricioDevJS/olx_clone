import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    getAd();
    return Scaffold(
      appBar: AppBar(
        title: Text("Todas as Categorias"),
      ),
      body: FutureBuilder(
        future: getAd(),
        builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(CupertinoIcons.car_detailed),
                title: Text(
                  snapshot.data[index]['name'],
                  style: TextStyle(fontSize: 20),
                ),
              );
            },
          );
        },
      ),
    );
  }

  getAd() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;
    var categorias = await db.collection('Categorias').get();
    return categorias.docs;
  }
}
