import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';

class Dictionnaire {
  List<String> lesMots = [];
  late Random rand;

  Dictionnaire(String nomFichier, int longueurMinDesMots, int longueurMaxDesMots) {
    var file = File("assets/data/mot.csv");
    print(file.existsSync() ? 'Le fichier existe' : 'Le fichier n\'existe pas');
    try {
      var lecteurAvecBuffer = File("assets/data/mot.csv").openRead().transform(utf8.decoder);
      print(lecteurAvecBuffer);
      print('Ouverture du fichier $nomFichier');
      lecteurAvecBuffer.forEach((String ligne) {
        print('Ligne lue: $ligne');
        var mot = sansAccents(ligne.trim()).toUpperCase(); // Trim pour supprimer les espaces en début et fin de ligne
        var longueurDuMot = mot.length;
        if (RegExp(r'^[A-Z\-]*$').hasMatch(mot)) {
          if (longueurDuMot >= longueurMinDesMots && longueurDuMot <= longueurMaxDesMots) {
            lesMots.add(mot);
          }
        }
      });
    } catch (e) {
      print('Erreur lors de l\'ouverture du fichier $nomFichier');
      exit(1);
    }
    rand = Random();
  }

  String choisirMot() {
    var i = rand.nextInt(lesMots.length);
    return lesMots[i];
  }

  static String sansAccents(String mot) {
    String motSansAccents = '';
    for (var i = 0; i < mot.length; i++) {
      var lettre = mot[i];
      if (lettre == 'À' || lettre == 'Â' || lettre == 'Ä') {
        motSansAccents += 'A';
      } else if (lettre == 'Ç') {
        motSansAccents += 'C';
      } else if (lettre == 'É' || lettre == 'È' || lettre == 'Ê' || lettre == 'Ë') {
        motSansAccents += 'E';
      } else if (lettre == 'Î' || lettre == 'Ï') {
        motSansAccents += 'I';
      } else if (lettre == 'Ô' || lettre == 'Ö') {
        motSansAccents += 'O';
      } else if (lettre == 'Ù' || lettre == 'Û' || lettre == 'Ü') {
        motSansAccents += 'U';
      } else {
        motSansAccents += lettre;
      }
    }
    return motSansAccents;
  }
}
