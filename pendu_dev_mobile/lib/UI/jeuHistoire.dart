import '../model/mot_mystere.dart';
import 'package:flutter/material.dart';
import '../database/databaseHelper.dart';
import 'home.dart';

class JeuHistoire extends StatefulWidget {
  final int ancienLevel;
  final String pseudo;

  JeuHistoire(this.pseudo, this.ancienLevel);

  @override
  _JeuHistoireState createState() => _JeuHistoireState(ancienLevel, pseudo);
}

class _JeuHistoireState extends State<JeuHistoire> {
  late int ancienLevel;
  late String pseudo;
  late MotMystere motMystere;
  int index = 0;
  final List<Image> images = [
    Image.asset('icones/pendu0.png', height: 350, width: 350),
    Image.asset('icones/pendu1.png', height: 350, width: 350),
    Image.asset('icones/pendu2.png', height: 350, width: 350),
    Image.asset('icones/pendu3.png', height: 350, width: 350),
    Image.asset('icones/pendu4.png', height: 350, width: 350),
    Image.asset('icones/pendu5.png', height: 350, width: 350),
    Image.asset('icones/pendu6.png', height: 350, width: 350),
    Image.asset('icones/pendu7.png', height: 350, width: 350),
    Image.asset('icones/pendu8.png', height: 350, width: 350),
    Image.asset('icones/pendu9.png', height: 350, width: 350),
    Image.asset('icones/pendu10.png', height: 350, width: 350),
  ];

  _JeuHistoireState(int ancienLevel, String pseudo) {
    this.ancienLevel = ancienLevel;
    this.pseudo = pseudo; // Initialisation de la variable pseudo
    // Niveau max 3 donc si le niveau est supérieur à 3 on le remet à 3
    int numLevel = ancienLevel > 3 ? 3 : ancienLevel;
    this.motMystere = MotMystere('assets/data/mot.csv', 2, 10, numLevel);
    this.motMystere.setMotATrouver2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          // Affiche le niveau actuel
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Niveau ${this.ancienLevel + 1}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              motMystere.motCrypte,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          images[index],
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              children: List.generate(26, (index) {
                final letter = String.fromCharCode('A'.codeUnitAt(0) + index);
                bool isDisabled = motMystere.lettreDejaEssayee(letter); // Vérifie si la lettre a déjà été essayée
                return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: isDisabled // Désactive le bouton si la lettre a déjà été essayée
                        ? null
                        : () {
                      int nbFois = motMystere.essaiLettre(letter);
                      this.majAffichage(nbFois);
                      if (motMystere.gagne()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Bravo $pseudo !'),
                              content: Text(
                                  'Vous avez gagné en ${motMystere.getNbEssais()} essais.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Insérer le score et continuer
                                    DatabaseHelper.instance.insertScoreHistoire(pseudo, this.ancienLevel + 1);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JeuHistoire(pseudo, this.ancienLevel + 1),
                                      ),
                                    );
                                  },
                                  child: Text('Continuer'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    DatabaseHelper.instance.insertScoreHistoire(pseudo, this.ancienLevel + 1);
                                    Navigator.pop(context); // Ferme la boîte de dialogue
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Home()),
                                    );
                                  },
                                  child: Text('Quitter'),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (motMystere.perdu()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Perdu $pseudo !'),
                              content: Text(
                                  'Le mot à trouver était ${motMystere.motATrouver}.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(letter),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void majAffichage(int nbFois) {
    if (nbFois > 0) {
      setState(() {
        motMystere.motCrypte = motMystere.getMotCrypte();
      });
    } else {
      setState(() {
        index++;
      });
    }
  }
}
