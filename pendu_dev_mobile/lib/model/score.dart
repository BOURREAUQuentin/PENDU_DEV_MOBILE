class Score {
  final int? id;
  final String pseudo;
  final int numLevel;
  final int score;

  Score({this.id, required this.pseudo, required this.numLevel, required this.score});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pseudo': pseudo,
      'numLevel': numLevel,
      'score': score,
    };
  }

  @override
  String toString() {
    return 'Score{id: $id, pseudo: $pseudo, numLevel: $numLevel, score: $score}';
  }
}