import 'package:flutter/material.dart';

import '../BoardButton.dart';
import '../MainMenu.dart';
import '../ScoreText.dart';


class Board_2Players extends StatefulWidget {
  static const String routeName = 'Board_2Players';
  @override
  _Board_2PlayersState createState() => _Board_2PlayersState();
}

class _Board_2PlayersState extends State<Board_2Players> {
  List<String>boardState = ['', '', '',
    '', '', '',
    '', '', ''];
  int counter = 0;
  int playerXScore=0;
  int playerOScore=0;
  String player1Name='';
  String player2Name='';
  String playerTurn='X';
  Color winnerColor = Color.fromRGBO(
      255, 183, 3, 1.0);
  List<Color>winnerBackGround=[Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0)];
  @override
  Widget build(BuildContext context) {
    var args = (ModalRoute.of(context)?.settings.arguments) as BoardArgs;
    player1Name= args.player1Name;
    player2Name= args.player2Name;
    if(player1Name==''){player1Name='Player 1';}
    if(player2Name==''){player2Name='Player 2';}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(202, 240, 248, 1.0),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(2, 62, 138, 1.0),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color:  Color.fromRGBO(202, 240, 248, 1.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color:  Color.fromRGBO(202, 240, 248, 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Score(player1Name,playerXScore,'X'),
                    Score(player2Name,playerOScore,'O')
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Player's turn: $playerTurn",style: TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(2, 62, 138, 1.0),
                    //fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BoardButton(boardState[0],0,onPlay,winnerBackGround[0]),
                  BoardButton(boardState[1],1,onPlay,winnerBackGround[1]),
                  BoardButton(boardState[2],2,onPlay,winnerBackGround[2])
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BoardButton(boardState[3],3,onPlay,winnerBackGround[3]),
                  BoardButton(boardState[4],4,onPlay,winnerBackGround[4]),
                  BoardButton(boardState[5],5,onPlay,winnerBackGround[5])
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BoardButton(boardState[6],6,onPlay,winnerBackGround[6]),
                  BoardButton(boardState[7],7,onPlay,winnerBackGround[7]),
                  BoardButton(boardState[8],8,onPlay,winnerBackGround[8])
                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: Container(margin:EdgeInsets.only(left: 2,right: 2),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(
                            255, 183, 3, 1.0))
                    ),
                    onPressed: (){
                      setState(() {
                        resetBoard();
                        if(playerTurn=='X')counter=0;
                        else if(playerTurn=='O')counter=1;
                      });
                    },
                    child: Text('Restart',style: TextStyle(
                      color: Color.fromRGBO(2, 62, 138, 1.0),
                    ),),
                  ),
                )
                ),
                Expanded(
                  child:  Container(margin: EdgeInsets.only(left: 2,right: 2),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(
                              240, 113, 103, 1.0))
                      ),
                      onPressed: (){
                        setState(() {
                          resetBoard();
                          playerXScore=0;
                          playerOScore=0;
                          counter=0;
                          playerTurn='X';
                        });
                      },
                      child: Text('Reset',
                        style: TextStyle(
                            color: Color.fromRGBO(2, 62, 138, 1.0),
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container(margin:EdgeInsets.only(left: 2,right: 2),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(2, 62, 138, 1.0),)
                    ),
                    onPressed: (){
                      setState(() {
                        Navigator.pushNamed(context, MainMenu.routeName);
                      });
                    },
                    child: Text('New Game',style: TextStyle(
                      color:  Color.fromRGBO(248, 249, 250, 1.0),
                    ),),
                  ),
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
  void onPlay(index) {
    if(boardState[index].isNotEmpty) return ;
    boardState[index]=counter%2==0?'X':'O';
    counter++;
    if(checkWinner('X')){
      playerXScore+=1;
      playerTurn='X';
      counter=0;
    }
    else if (checkWinner('O')){
      playerOScore+=1;
      playerTurn='O';
      counter=1;
    }
    else if(counter>=9){
      counter=0;
    }
    setState(() {});
  }
  bool checkWinner(String playerCode){
    int x=-1;
    for(int i=0;i<9;i+=3){
      if(boardState[i]==playerCode&&
          boardState[i+1]==playerCode&&
          boardState[i+2]==playerCode) {
        winnerBackGround[i]=winnerColor;
        winnerBackGround[i+1]=winnerColor;
        winnerBackGround[i+2]=winnerColor;
        x=1;
      }
    }
    if (x==1){
      for(int i=0;i<9;i++){
        if(boardState[i].isEmpty)
          boardState[i]=' ';
      }
      return true;
    }
    for(int i=0;i<3;i++){
      if(boardState[i]==playerCode&&
          boardState[i+3]==playerCode&&
          boardState[i+6]==playerCode) {
        winnerBackGround[i]=winnerColor;
        winnerBackGround[i+3]=winnerColor;
        winnerBackGround[i+6]=winnerColor;
        x=1;
      }
    }
    if (x==1){
      for(int i=0;i<9;i++){
        if(boardState[i].isEmpty)boardState[i]=' ';
      }
      return true;
    }
    if(boardState[0]==playerCode&&
        boardState[4]==playerCode&&
        boardState[8]==playerCode) {
      winnerBackGround[0]=winnerColor;
      winnerBackGround[4]=winnerColor;
      winnerBackGround[8]=winnerColor;
      x=1;
    }
    if (x==1){
      for(int i=0;i<9;i++){
        if(boardState[i].isEmpty)boardState[i]=' ';
      }
      return true;
    }
    if(boardState[2]==playerCode&&
        boardState[4]==playerCode&&
        boardState[6]==playerCode) {
      winnerBackGround[2]=winnerColor;
      winnerBackGround[4]=winnerColor;
      winnerBackGround[6]=winnerColor;
      x=1;
    }
    if (x==1){
      for(int i=0;i<9;i++){
        if(boardState[i].isEmpty)boardState[i]=' ';
      }
      return true;
    }
    return false;
  }
  void resetBoard(){
    boardState = ['', '', '', '', '', '', '', '', ''];
    winnerBackGround=[Color.fromRGBO(144, 224, 239, 1.0),
      Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0),
      Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0),
      Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0),Color.fromRGBO(144, 224, 239, 1.0)];
  }
}
class BoardArgs{
  String player1Name;
  String player2Name;
  BoardArgs({required this.player1Name,required this.player2Name});
}