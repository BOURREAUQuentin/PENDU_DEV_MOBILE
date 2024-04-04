import 'dart:collection';
import 'dart:math';

class MotMystere {

  static List<String> mots = [
    'MANGER',
    'BOIRE',
    'HELICOPTERE',
    'AVION',
    'VOITURE',
    'BATEAU',
    'INFORMATIQUE',
    'TELEPHONE',
    'ORDINATEUR',
    'TABLETTE',
    'ECRAN',
    'CLAVIER',
    'SOURIS',
    'JAVASCRIPT',
    'PYTHON',
    'DART',
    'FLUTTER',
    'ANDROID',
    'WINDOWS',
    'LINUX',
    'MACOS',
    'UBUNTU',
    'DEBIAN',
    'FOOTBALL',
    'BASKETBALL',
    'TENNIS',
    'RUGBY',
    'HANDBALL',
    'VOLLEYBALL',
    'BASEBALL',
    'GOLF',
    'ATHLETISME',
    'POWERLIFTING',
    'HALTEROPHILIE',
    'CHOCOLAT',
    'VANILLE',
    'FRAISE',
    "AUSTRALIE",
    "BELGIQUE",
    "CANADA",
    "DANEMARK",
    "ESPAGNE",
    "FRANCE",
    "GRECE",
    "HONGRIE",
    "ITALIE",
    "RAVIOLI",
    "LASAGNE",
    "PIZZA",
    "HAMBURGER",
    "SANDWICH",
    "KEBAB",
    "TACOS",
    "BURRITO",
    "SUSHI",
    "NARUTO",
  ];

  static const int FACILE = 1;
  static const int MOYEN = 2;
  static const int DIFFICILE = 3;

  late String motATrouver;

  late int niveau;

  late String motCrypte;

  Set<String> lettresEssayees = HashSet<String>();

  int nbLettresRestantes = 0;

  int nbEssais = 0;

  int nbErreursRestantes = 0;

  int nbEerreursMax = 0;


  //late Dictionnaire dict;

  MotMystere(String nomFichier, int longMin, int longMax, int niveau) {

    initMotMystere(niveau);
  }

  void initMotMystere(int niveau) {
    var i = Random().nextInt(mots.length);
    this.motATrouver = mots[i];
    this.niveau = niveau;
    nbEssais = 0;
    motCrypte = "";
    lettresEssayees = HashSet<String>();
    nbLettresRestantes = 0;

    if (niveau == DIFFICILE) {
      motCrypte = "*";
      nbLettresRestantes += 1;
    } else {
      motCrypte += this.motATrouver[0];
    }

    for (int i = 1; i < motATrouver.length - 1; i++) {
      var lettre = this.motATrouver[i];
      if (RegExp(r'^[A-Z]$').hasMatch(lettre)) {
        motCrypte += "*";
        nbLettresRestantes += 1;
      } else {
        motCrypte += lettre;
      }
    }

    if (niveau != FACILE) {
      motCrypte += "*";
      nbLettresRestantes += 1;
    } else {
      motCrypte += this.motATrouver[motATrouver.length - 1];
    }
    nbEerreursMax = 10;
    nbErreursRestantes = 10;
  }

  String getMotATrouve() {
    return motATrouver;
  }

  int getNiveau() {
    return niveau;
  }

  void setMotATrouver2() {
    initMotMystere(niveau);
  }

  void setNiveau(int niveau) {
    this.niveau = niveau;
  }

  String getMotCrypte() {
    return motCrypte;
  }

  Set<String> getLettresEssayees() {
    return lettresEssayees;
  }

  bool lettreDejaEssayee(String lettre) {
    return lettresEssayees.contains(lettre);
  }

  int getNbLettresRestantes() {
    return nbLettresRestantes;
  }

  int getNbEssais() {
    return nbEssais;
  }

  int getNbErreursMax() {
    return nbEerreursMax;
  }

  int getNbErreursRestants() {
    return nbErreursRestantes;
  }

  bool perdu() {
    return nbErreursRestantes == 0;
  }

  bool gagne() {
    return nbLettresRestantes == 0;
  }

  int essaiLettre(String lettre) {
    int nbNouvelles = 0;
    var aux = motCrypte.runes.toList();
    for (int i = 0; i < motATrouver.length; i++) {
      if (motATrouver[i] == lettre && motCrypte[i] == '*') {
        nbNouvelles += 1;
        aux[i] = lettre.runes.first;
      }
    }
    motCrypte = String.fromCharCodes(aux);
    nbLettresRestantes -= nbNouvelles;
    lettresEssayees.add(lettre);
    nbEssais += 1;
    if (nbNouvelles == 0) {
      nbErreursRestantes -= 1;
    }
    return nbNouvelles;
  }
}
