import '../model/mot_mystere.dart';
import 'package:flutter/material.dart';

class Jeu extends StatefulWidget {
  final int numLevel;
  final String pseudo;

  Jeu(this.numLevel, this.pseudo);

  @override
  _JeuState createState() => _JeuState(numLevel, pseudo);
}

class _JeuState extends State<Jeu> {
  late int numLevel;
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

  _JeuState(this.numLevel, this.pseudo) {
    this.motMystere = MotMystere('assets/data/mot.csv', 2, 10, numLevel);
    this.motMystere.setMotATrouver2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
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
