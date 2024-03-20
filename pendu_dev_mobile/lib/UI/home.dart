import 'package:flutter/material.dart';
import 'rules.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('icones/pendu.png'),
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            'Pendu',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 300),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonWithImageAndText(
                'leaderboard',
                'icones/leaderboard.png',
                'Leaderboard',
              ),
              _buildButtonWithImageAndText(
                'play',
                'icones/play.png',
                'Play',
              ),
              _buildButtonWithImageAndText(
                'rules',
                'icones/rules.png',
                'Rules',
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWithImageAndText(String page, String imagePath, String textBelow, {BuildContext? context}) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (page == 'rules') {
              Navigator.push(
                context!,
                MaterialPageRoute(builder: (context) => Rules()),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Ajustez la valeur pour obtenir des boutons plus carrés
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 8),
              Image.asset(
                imagePath,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8), // Espacement entre l'image et le texte
            ],
          ),
        ),
        SizedBox(height: 8), // Espacement entre le bouton et le texte en dessous
        Text(textBelow),
      ],
    );
  }
}
