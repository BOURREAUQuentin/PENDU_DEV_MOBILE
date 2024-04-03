import 'package:flutter/material.dart';
import '../database/databaseHelper.dart';
import '../model/score.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Score>>(
        future: DatabaseHelper.instance.getScore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Center(
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: Colors.grey),
                              children: [
                                TableCell(child: Center(child: Text('Nom', style: TextStyle(fontWeight: FontWeight.bold)))),
                                TableCell(child: Center(child: Text('Level', style: TextStyle(fontWeight: FontWeight.bold)))),
                                TableCell(child: Center(child: Text('Essais', style: TextStyle(fontWeight: FontWeight.bold)))),
                              ],
                            ),
                            for (var i = 0; i < snapshot.data!.length; i++)
                              TableRow(
                                children: [
                                  TableCell(child: Center(child: Text(snapshot.data![i].pseudo))),
                                  TableCell(child: Center(child: Text('${snapshot.data![i].numLevel}'))),
                                  TableCell(child: Center(child: Text('${snapshot.data![i].score}'))),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      DatabaseHelper.instance.deleteAll();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Leaderboard()));
                    },
                    child: Text('Supprimer l''historique'),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Aucune donnée disponible'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
