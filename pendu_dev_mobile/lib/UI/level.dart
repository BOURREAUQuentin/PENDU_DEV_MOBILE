import 'package:flutter/material.dart';
import 'package:sae/database/databaseHelper.dart';
import 'jeu.dart';
import 'jeuHistoire.dart';

class Level extends StatelessWidget {
  const Level({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          Text('Choisissez la difficulté pour commencer à jouer.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 20),
          _buildLevelButton('Histoire', 'Mode histoire le niveau augmente petit à petit', 0, context),
          SizedBox(height: 20),
          _buildLevelButton('Facile', 'Difficulté facile, 2 lettres visibles', 1, context),
          SizedBox(height: 20),
          _buildLevelButton('Normal', 'Difficulté normale, 1 lettre visible', 2, context),
          SizedBox(height: 20),
          _buildLevelButton('Difficile', 'Difficulté difficile, aucune lettre visible', 3, context),
        ],
      ),
    );
  }

  Widget _buildLevelButton(String levelName, String difficulty, int levelNumber, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (levelNumber == 0) {
          _showDialogHistoire(context);
        } else {
          _showPseudoDialog(context, levelNumber);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Text(
            levelName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            difficulty,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _showDialogHistoire(BuildContext context) {
    String pseudo = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Entrez votre pseudo'),
          content: TextField(
            onChanged: (value) {
              pseudo = value;
            },
            decoration: InputDecoration(
              hintText: 'Pseudo',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                bool userExist = await DatabaseHelper.instance.checkUser(pseudo);
                if (userExist) {
                  int? level = await DatabaseHelper.instance.getLevel(pseudo);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Attention'),
                        content: Text('Vous avez déjà commencé le mode histoire, vous avez réussi le niveau $level. Vous allez reprendre au niveau suivant.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => JeuHistoire(pseudo, level!)),
                              );
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Si l'utilisateur n'existe pas encore, on le redirige directement vers le jeu
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JeuHistoire(pseudo, 0)),
                  );
                }
              },
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
  }

  void _showPseudoDialog(BuildContext context, int numLevel) {
    String pseudo = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Entrez votre pseudo'),
          content: TextField(
            onChanged: (value) {
              pseudo = value;
            },
            decoration: InputDecoration(
              hintText: 'Pseudo',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Jeu(numLevel, pseudo)),
                );
              },
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
  }
}
