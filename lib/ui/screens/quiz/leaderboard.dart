import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/core/quiz/quiz_repository.dart';
import 'package:bebkeler/infrastructure/mvvm/view.dart';
import 'package:bebkeler/ui/screens/quiz/leaderboard_view_model.dart';
import 'package:flutter/material.dart';

class QuizLeaderboard extends StatelessWidget {
  final String collectionPath;
  final QuizLeaderboardViewModel viewModel;

  QuizLeaderboard({Key key, this.collectionPath})
      : viewModel = QuizLeaderboardViewModel(collectionPath, QuizRepository.instance),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewBuilder<QuizLeaderboardViewModel>(
      viewModel: viewModel,
      builder: (context, vm, _) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFFB721FF), Color(0xFF21D4FD)])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.white70),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Text(
                          'MATH NINJA LEADERS',
                          style: TextStyle(fontSize: 20.0, color: Colors.indigo),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        child: ListView.builder(
                          itemCount: vm.results.length,
                          itemBuilder: (context, index) {
                            return UserTile(result: vm.results[index], number: index + 1);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final QuizResult result;
  final int number;
  UserTile({this.result, this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.indigoAccent,
              child: Text(number.toString()),
            ),
            title: Text(
              result.userDisplayName,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 20.0, color: Colors.black.withOpacity(0.7)),
            ),
            subtitle: Text(
                'Points: ${result.score}    Ratio: ${result.score.toDouble() / result.maxScore}',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 15.0)),
          ),
        ),
      ),
    );
  }
}
