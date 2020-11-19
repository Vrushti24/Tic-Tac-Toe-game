import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool xturn = true; //the first player is X
  List<String> xoro = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  int xscore = 0;
  int oscore = 0;
  int fullbox = 0;

  static var myfont = GoogleFonts.lato(
      textStyle:
          TextStyle(color: Colors.black, letterSpacing: 1, fontSize: 20));
  static var myfontwhite = GoogleFonts.lato(
      textStyle:
          TextStyle(color: Colors.black, letterSpacing: 1, fontSize: 20));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: Text('Tic-Tac-Toe'), backgroundColor: Colors.black),
        backgroundColor: Colors.brown[500],
        body: Column(
          children: [
            Expanded(
                child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player1',
                          style: myfont,
                        ),
                        Text(
                          xscore.toString(),
                          style: myfont,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player2',
                          style: myfontwhite,
                        ),
                        Text(
                          oscore.toString(),
                          style: myfontwhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tap(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown[400])),
                        child: Center(
                          child: Text(
                            xoro[index],
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(child: Container()),
          ],
        ));
  }

  void _tap(int index) {
    setState(() {
      if (xturn && xoro[index] == '') {
        xoro[index] = 'X';
        fullbox += 1;
      } else if (!xturn && xoro[index] == '') {
        xoro[index] = 'O';
        fullbox += 1;
      }
      xturn = !xturn;
      _checkwin();
    });
  }

  void _checkwin() {
    //first row
    if (xoro[0] == xoro[1] && xoro[0] == xoro[2] && xoro[0] != '') {
      _show(xoro[0]);
    }
    //second row
    if (xoro[3] == xoro[4] && xoro[3] == xoro[5] && xoro[3] != '') {
      _show(xoro[3]);
    }
    //third row
    if (xoro[6] == xoro[7] && xoro[6] == xoro[8] && xoro[6] != '') {
      _show(xoro[6]);
    }
    //first column
    if (xoro[0] == xoro[3] && xoro[0] == xoro[6] && xoro[0] != '') {
      _show(xoro[0]);
    }
    //second column
    if (xoro[1] == xoro[4] && xoro[1] == xoro[7] && xoro[1] != '') {
      _show(xoro[1]);
    }
    //third column
    if (xoro[2] == xoro[5] && xoro[2] == xoro[8] && xoro[2] != '') {
      _show(xoro[2]);
    }
    //first diagonal
    if (xoro[0] == xoro[4] && xoro[0] == xoro[8] && xoro[0] != '') {
      _show(xoro[0]);
    }
    //second diagonal
    if (xoro[2] == xoro[4] && xoro[2] == xoro[6] && xoro[2] != '') {
      _show(xoro[2]);
    }
    //draw match
    else if (fullbox == 9) {
      _drawbox();
    }
  }

  void _show(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner is : " + winner),
            actions: [
              FlatButton(
                child: Text('Play Again'),
                onPressed: () {
                  _nextboard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'X') {
      xscore = xscore + 1;
    } else if (winner == 'O') {
      oscore = oscore + 1;
    }
  }

  void _drawbox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Its Draw'),
            actions: [
              FlatButton(
                child: Text('Play Again'),
                onPressed: () {
                  _nextboard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _nextboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        xoro[i] = '';
      }
    });

    fullbox = 0;
  }
}