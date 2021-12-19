import 'package:flutter/material.dart';

class Score extends  StatelessWidget {
  String playerName;
  int playerScore;
  String code;
  Score(this.playerName,this.playerScore,this.code);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Column(
                children: [
                  playerName!='Draw'?
                  Text('$playerName ($code)',style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(2, 62, 138, 1.0),
                      fontWeight: FontWeight.bold
                  ),): Text('$playerName',style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(2, 62, 138, 1.0),
                      fontWeight: FontWeight.bold
                  ),)
                ],
              ),
              Column(
                children: [
                  Text('$playerScore',style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(2, 62, 138, 1.0),
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
