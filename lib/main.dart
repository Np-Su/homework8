import 'dart:math';

import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),*/
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  late Game _game;

  HomePage({Key? key}) : super(key: key) {
    _game = Game(maxRandom: 100);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  String _input = '';
  late String message='ทายเลข 1 ถึง 100';
  void _showOkDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var showSeven = true;

    return Scaffold(
      /*appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),*/
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.shade100,
                offset: Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', height: 85, width: 60,),
                    SizedBox(width: 8.0),
                    Column(
                      //mainAxisSize: MainAxisSize.min
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('GUESS',
                          style:TextStyle(fontSize: 36.0, color: Colors.purple),
                        ),
                        Text('THE NUMBER',
                          style:TextStyle(fontSize: 18.0, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_input,style: TextStyle(fontSize: 40.0),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message,style: TextStyle(fontSize: 20.0),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 1; i <= 3; i++) _buildButton4(num :i),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 4; i <= 6; i++) _buildButton4(num: i),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 7; i <= 9; i++) _buildButton4(num: i),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          var length = _input.length;
                          _input = _input.substring(0,length-1);
                        });
                      },
                      child:Container(width: 60,height: 55,decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 1.0)
                      ),child: Icon(
                        Icons.backspace,         // รูปไอคอน
                        size:30.0,           // ขนาดไอคอน
                        color: Colors.black,
                        // สีไอคอน
                      ),
                      ),
                    ),

                  ),
                  Container(width: 70,height: 55,child: _buildButton4(num:0),),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                            _input ='';
                        });
                      },
                      child: Container(width: 60,height: 55,decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 1.0)
                      ),
                          child: Icon(
                            Icons.backspace,         // รูปไอคอน
                            size:30.0,           // ขนาดไอคอน
                            color: Colors.indigoAccent,   // สีไอคอน
                          )
                      ),
                    ),

                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('GUESS'),
                  onPressed: () {
                    var input = _input;
                    var guess = int.tryParse(input);

                    /*if (guess == null) {
                      _showOkDialog(context, 'ERROR',
                          'กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น');
                      return;
                    }*/


                    var guessResult = widget._game.doGuess(guess!);
                    if (guessResult > 0) {
                      message = '$guess : มากเกินไป ';
                    } else if (guessResult < 0) {
                      message = '$guess : น้อยเกินไป ';
                    } else {
                      message =
                      '$guess : ถูกต้อง 🎉 ทาย (${widget._game.guessCount}) ครั้ง';
                    }

                  //  _showOkDialog(context, 'RESULT', message);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton({int? num}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
          onPressed: () {
            print('You pressed $num');
          },
          child: Text('$num')),
    );
  }

  Widget _buildButton4({int? num}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child:InkWell(
        onTap:(){
          if(_input.length < 3){
            setState(() {
            _input ='$_input$num';
          });
          }

        },
        child: Container(
          width: 60.0,
          height: 60.0,
          //color: Colors.green, // ห้ามกำหนด color ตรงนี้ ถ้าหากกำหนดใน BoxDecoration แล้ว
          decoration: BoxDecoration(
            //color: Colors.white,
            //shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
                '$num',
                textAlign: TextAlign.center,
                style:TextStyle(fontSize: 20)
            ),
          ),
        ),

      ),

    );
  }






  Widget _buildButton5({int? num}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child:InkWell(
        onTap:(){
          if(_input.length < 3){
            setState(() {
              _input ='$_input$num';
            });
          }

        },
        child: Container(
          width: 60.0,
          height: 60.0,
          //color: Colors.green, // ห้ามกำหนด color ตรงนี้ ถ้าหากกำหนดใน BoxDecoration แล้ว
          decoration: BoxDecoration(
            //color: Colors.white,
            //shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
                '$num',
                textAlign: TextAlign.center,
                style:TextStyle(fontSize: 20)
            ),
          ),
        ),

      ),

    );
  }
}