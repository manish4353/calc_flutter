import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Calc Flutter',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String output = "0";
  String _output = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if(buttonText == "CLEAR"){
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if(buttonText=="+" || buttonText=="/" || buttonText=="-" || buttonText=="X"){
      num1 = double.parse(output);
      print("num1 set:" + num1.toString());
      operand = buttonText;
      _output = "0";
    } else if(buttonText=="."){
      if(_output.contains(".")){
        print("Already contains a decimal");
        return;
      } else{
        _output += buttonText;
      }
    } else if(buttonText=="="){
      num2 = double.parse(output);
      print("num2 set:" + num2.toString());

      if(operand=="+"){
        _output = (num1 + num2).toString();
      }
      if(operand=="-"){
        _output = (num1 - num2).toString();
      }
      if(operand=="X"){
        _output = (num1 * num2).toString();
      }
      if(operand=="/"){
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else{
      _output = _output + buttonText;
    }

    print(_output);
    setState(() {
      if(_output == "Infinity" || _output == "NaN"){
        output = _output;
        print(output);
      } else if(double.tryParse(_output)!=null && double.parse(_output).ceil() == double.parse(_output)){
        print("int");
        output = double.parse(_output).ceil().toString();
        print(output);
      }else if(double.tryParse(_output)!=null){
        print("double");
        output = double.parse(_output).toStringAsFixed(6);
        print(output);
      }
/*      for(int i=output.length-1;i>=0;i--){

      }*/
    });
  }

  Widget getButton(String buttonText) {
    return Expanded(
      child: OutlineButton(
        padding: EdgeInsets.all(24.0),
        child: Text(buttonText,
          style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          ),
        ),
      onPressed: () => buttonPressed(buttonText),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: 0.0,
        leading: Icon(Icons.local_hospital),
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            Expanded(child: Divider()),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(output,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    getButton("7"),
                    getButton("8"),
                    getButton("9"),
                    getButton("/"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    getButton("4"),
                    getButton("5"),
                    getButton("6"),
                    getButton("X"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    getButton("1"),
                    getButton("2"),
                    getButton("3"),
                    getButton("-"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    getButton("."),
                    getButton("0"),
                    getButton("00"),
                    getButton("+"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    getButton("CLEAR"),
                    getButton("="),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
