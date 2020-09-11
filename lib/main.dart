import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Sumas(title: 'Juega y Aprende'),
    );
  }
}

class Sumas extends StatefulWidget {
  Sumas({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SumasState createState() => _SumasState();
}

class _SumasState extends State<Sumas> {
  int _counter = 0;
  int _correctCounter = 0;
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  bool _isInputEnabled = false;
  bool _isCorrect;
  int _randomLeft = 0;
  int _randomRight = 0;
  final _randomLeftController = TextEditingController();
  final _randomRightController = TextEditingController();
  final _userInputController = TextEditingController();
  var _iconWidgets = List<Widget>();

  void _newGame() {
    setState(() {
      _isButtonEnabled = true;
      _isInputEnabled = true;
      _generateRandom();
      _iconWidgets.clear();
      _userInputController.text='';
      _counter=0;
      _correctCounter=0;
    });
  }

  void _generateRandom() {
    setState(() {
      Random random1 = new Random();
      _randomLeft = random1.nextInt(100);
      _randomLeftController.text = _randomLeft.toString();
      Random random2 = new Random();
      _randomRight = random2.nextInt(100);
      _randomRightController.text = _randomRight.toString();
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _calculateSum() {
    setState(() {
      if(_counter>4){
        _iconWidgets.clear();
        _counter=0;
        _sum();
        _userInputController.text='';
        _generateRandom();
      }
      else{
        _sum();
        _userInputController.text='';
        _generateRandom();
      }
      _incrementCounter();
    });
  }

  void _sum(){
    int sum = _randomLeft + _randomRight;
    if (sum == int.parse(_userInputController.text)) {
      _isCorrect = true;
      _iconWidgets.add(Icon(Icons.check_circle, color: Colors.green,));
      _correctCounter++;
    } else {
      _correctCounter=0;
      _isCorrect = false;
      _iconWidgets.add(Icon(Icons.cancel, color: Colors.red,));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildInputsRow(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RaisedButton(
                color: Colors.green,
                  child: Text(
                      '=',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _isButtonEnabled ? _calculateSum() : null;
                    }
                  }
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 115, right: 115, top: 30, bottom: 30),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  enabled: _isInputEnabled,
                  controller: _userInputController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ingresa tu respuesta';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10)
                    ),
                  )
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 115, right: 115, bottom: 10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: _iconWidgets
                ),
              ),
            ),
            Center(child: Text('Aciertos seguidos: '+_correctCounter.toString())
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newGame,
        tooltip: 'New Game',
        child: Icon(Icons.fiber_new),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Row _buildInputsRow() {
    return Row(
      children: [
        _buildRandomField(_randomLeftController),
        Flexible(
          child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 0),
              child: new RaisedButton(
                onPressed: (){},
                color: Colors.redAccent,
                child: Icon(Icons.add,color: Colors.white,),
              )
          ),
        ),
        _buildRandomField(_randomRightController),
      ],
    );
  }

  Flexible _buildRandomField(controller) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child:  TextField(
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            enabled: false,
            controller: controller,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10)
            )
        ),
      ),
    );
  }
}










