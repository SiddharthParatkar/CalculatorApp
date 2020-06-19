import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Simple Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String display = '0';
  String stringNum = '0';
  double result = 0.0;
  String operation;

  Widget createRow(String title1, String title2, String title3, String title4){
    return Expanded(
      child: Row(
        children: <Widget>[
          createButton(title1),
          createButton(title2),
          createButton(title3),
          createButton(title4),
        ],
      ),
    );
  }

  Widget createButton(String title){
    return Expanded(
      child: ButtonTheme(
        height: double.infinity,
        child: OutlineButton(
          onPressed: () => pressButton(title),
          child: Text(title),
        ),
      ),
    );
  }

  pressButton(String title){
    setState(() {
      if (title == '+' || title == '-' || title == '*' || title == '/'){
        result = double.parse(stringNum) ?? 0;
        stringNum = '';
        operation = title;
      }
      else if (title == '=') {
        calculate();
      }
      else if (title == 'CE') {stringNum = ''; display = '0'; result = 0;}
      else {
        if (stringNum == '0' || stringNum == '0.0') stringNum = '';
        stringNum += title;
        display = stringNum;
      }
    });
  }

  calculate(){
    switch (operation){
      case '+':
        result += double.parse(stringNum);
        break;
      case '-':
        result -= double.parse(stringNum);
        break;
      case '*':
        result *= double.parse(stringNum);
        break;
      case '/':
        result /= double.parse(stringNum);
        break;
      default:
        break;
    }
    stringNum = result.toString();
    display = stringNum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Text(
                      display,
                      style: TextStyle(fontSize: 80),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  createRow('+', '-', '*', '/'),
                  createRow('7', '8', '9', '0'),
                  createRow('4', '5', '6', 'CE'),
                  createRow('1', '2', '3', '='),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
