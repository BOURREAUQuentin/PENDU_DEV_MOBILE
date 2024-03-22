import 'package:flutter/material.dart';
import 'home.dart';

class Rules extends StatelessWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80), // Espacement entre le titre et les autres éléments
            Text('Vous avez un nombre limité de tentatives pour deviner le mot secret avant que le dessin du pendu ne soit complété.'),
            SizedBox(height: 20), // Espacement entre les textes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Il y a 3 niveaux possibles dans le jeu :\nniveau 1 : 2 lettres au départ sont visibles\nniveau 2 : 1 lettre au départ sont visibles\nniveau 3 : Aucune lettre au départ n’est visible'),
                SizedBox(width: 20), // Espacement entre le texte et l'image
                Image.asset(
                  'icones/niveaux.png', // Chemin de l'image
                  width: 50, // Largeur de l'image
                  height: 50, // Hauteur de l'image
                ),
              ],
            ),
            SizedBox(height: 20), // Espacement entre les textes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Si le pendu est complété avant que vous ne deviniez le mot, vous perdez la partie.'),
                SizedBox(width: 20), // Espacement entre le texte et l'image
                Image.asset(
                  'icones/gameover.png', // Chemin de l'image
                  width: 50, // Largeur de l'image
                  height: 50, // Hauteur de l'image
                ),
              ],
            ),
            SizedBox(height: 20), // Espacement entre les textes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Si vous devinez le mot avant que le pendu ne soit complété, vous remportez la partie.'),
                SizedBox(width: 20), // Espacement entre le texte et l'image
                Image.asset(
                  'icones/win.png', // Chemin de l'image
                  width: 50, // Largeur de l'image
                  height: 50, // Hauteur de l'image
                ),
              ],
            ),
            SizedBox(height: 20), // Espacement entre les textes
            Text('Proposez une lettre à la fois en suggérant une lettre qui pourrait être présente dans le mot secret :\nSi la lettre est correcte, elle sera révélée dans les emplacements appropriés du mot secret.\nSi la lettre est incorrecte, une partie du pendu sera dessinée pour indiquer votre erreur et la barre d\'erreurs augmentera en conséquence.'),
            SizedBox(height: 20), // Espacement entre les textes
            Text('Le jeu se termine lorsque vous devinez correctement le mot secret ou lorsque le dessin du pendu est complet.'),
          ],
        ),
      ),
    );
  }
}