import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hesap Makinesi',
      home: MyHomePage(title: 'Hesap Makinesi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var soru = '';
  var cevap = '';
  List<String> _button = [
    'C',
    'Sil',
    '%',
    '+',
    '7',
    '8',
    '9',
    '-',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '/',
    '.',
    '0',
    '^',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: Text(soru,style: TextStyle(fontSize: 30,color: Colors.white),)),
                    Container(alignment:Alignment.bottomRight,child: Text(cevap,style: TextStyle(fontSize: 30,color: Colors.white),)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _button.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, crossAxisSpacing: 20),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Buttonlar(
                        onTapp: (){
                          setState(() {
                            soru='';
                          });
                        },
                        yazi: _button[index],
                        yaziColor: Colors.white,
                        color: Colors.red,
                      );
                    } else if (index == 1) {
                      return Buttonlar(
                        onTapp: (){
                          setState(() {
                            soru=soru.substring(0,soru.length-1);
                          });
                        },
                        yazi: _button[index],
                        yaziColor: Colors.white,
                        color: Colors.red,
                      );
                    } else if (index == _button.length-1) {
                      return Buttonlar(
                        onTapp: (){
                          setState(() {
                            equalButton();
                          });
                        },
                        yazi: _button[index],
                        yaziColor: Colors.white,
                        color: Colors.green,
                      );
                    }else {
                      return Buttonlar(
                        onTapp: (){
                          setState(() {
                            soru+=_button[index];
                          });
                        },
                        yazi: _button[index],
                        yaziColor: rakamMi(_button[index])
                            ? Colors.white
                            : Colors.white,
                        color: rakamMi(_button[index])
                            ? Colors.orange
                            : Colors.grey.shade700,
                      );
                    }
                  }),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  bool rakamMi(String x) {
    if (x == '0' ||
        x == '1' ||
        x == '2' ||
        x == '3' ||
        x == '4' ||
        x == '5' ||
        x == '6' ||
        x == '7' ||
        x == '8' ||
        x == '9'||
        x == '.'||
        x == '^') {
      return false;
    }
    return true;
  }

  void equalButton(){

    Parser p = Parser();
    Expression exp = p.parse(soru);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    cevap=eval.toString();
  }
}



class Buttonlar extends StatelessWidget {
  final yaziColor;
  final String yazi;
  final color;
  final onTapp;
  Buttonlar({this.color, required this.yazi, this.yaziColor,this.onTapp});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTapp,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0, right: 5, left: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                yazi,
                style: TextStyle(color: yaziColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
