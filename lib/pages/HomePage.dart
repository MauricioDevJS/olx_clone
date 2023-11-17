import 'package:flutter/material.dart';
import 'package:ssclassificados/pages/LoginPage.dart';

import '../components/ListItens.dart';
import '../components/TabsFilter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isLoggeed = true;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (isLoggeed == false) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OLXis'),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 231, 226, 226),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Mauricio Cardoso Oliveira'),
            accountEmail: Text('mauricio@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: Image.network(
                  'https://static.vecteezy.com/ti/vetor-gratis/p3/4819327-avatar-masculino-perfil-icone-de-homem-caucasiano-sorridente-vetor.jpg'),
            ),
          ),
        ],
      )),
      body: Column(
        children: [TabsFilter(), ListItens()],
      ),
    );
  }
}
