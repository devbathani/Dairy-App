import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'Notes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main(){
  runApp(myapp());
}

class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dairy',
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text("DAIRY"),
            backgroundColor: Colors.pink,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.my_library_music), text: "Music",),
                Tab(icon: Icon(Icons.notes), text: "Notes",),
                Tab(icon: Icon(Icons.photo), text: "Images",),
                Tab(icon: Icon(Icons.calculate), text: "Calculator",),

              ],
            ),
          ),
          body: TabBarView(
            children: [
              music(),
              notes(),
              memory(),
              calculator(),

            ],
          ),
        ),
      )
    );
  }
}

class notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NotesPage(),
      );
  }
}
class music extends StatefulWidget {
  @override
  _musicState createState() => _musicState();
}

class _musicState extends State<music> {

  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider(){
    return Container(
      width: 250,
      child: Slider(
          activeColor: Colors.pink[500],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value){
            seekToSec(value.toInt());
           }
          ),
    );
  }
 void seekToSec(int sec){
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
 }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
    
    cache.load("lovely.mp3");
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightBlue[500],
              Colors.lightBlueAccent[100],
            ]
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Music Beats", style: TextStyle(
                     color: Colors.white,
                     fontSize: 35,
                     fontWeight: FontWeight.bold,
                   ),),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Listen to your favorite Music", style: TextStyle(
                     color: Colors.white,
                     fontSize: 20,
                     fontWeight: FontWeight.w400,
                   ),),
                 ),

                 SizedBox(
                   height: 20,
                 ),
                 Center(
                   child: Container(
                     width: 300,
                     height: 300,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30),
                       image: DecorationImage(
                         image: AssetImage("assets/images.jpg"),

                       ),
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 18,
                 ),
                 Center(
                   child: Text(
                     "Lovely",
                     style: TextStyle(
                       color: Colors.greenAccent,
                       fontSize: 20,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 24,
                 ),
                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.black,
                       borderRadius: BorderRadius.only(
                         topLeft: Radius.circular(30),
                         topRight: Radius.circular(30),
                       ),
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                           width: 500,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Text("${position.inMinutes}: ${position.inSeconds.remainder(60)}", style: TextStyle(
                                 fontSize: 16,
                                 color: Colors.greenAccent,
                               ),),
                               slider(),
                               Text("${musicLength.inMinutes}: ${musicLength.inSeconds.remainder(60)}",style: TextStyle(
                                 fontSize: 16,
                                 color: Colors.greenAccent,
                               ),),
                             ],
                           ),
                         ),

                         Row(

                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             FloatingActionButton(
                               splashColor: Colors.redAccent,
                               child: Icon(
                                 Icons.skip_previous,
                                 size: 35,
                                 color: Colors.lightBlueAccent,
                               ),
                                 backgroundColor: Colors.yellowAccent,
                                 onPressed: (){},
                             ),
                             FloatingActionButton(
                               backgroundColor: Colors.yellowAccent,
                               splashColor: Colors.redAccent,
                               child: Icon(Icons.play_arrow,
                               size: 35,
                                 color: Colors.lightBlueAccent,
                               ),
                               onPressed: () {
                                 if(!playing){
                                   cache.play("lovely.mp3");
                                   setState(() {
                                     playBtn = Icons.pause;
                                     playing = true;
                                   });
                                 }
                                 else
                                 {
                                   _player.pause();
                                   setState(() {
                                     playBtn = Icons.play_arrow;
                                     playing = false;
                                   });

                                 }
                               },
                             ),
                             FloatingActionButton(
                               splashColor: Colors.redAccent,
                               child: Icon(
                                 Icons.skip_next,
                                 size: 35,
                                 color: Colors.lightBlueAccent,

                               ),
                               backgroundColor: Colors.yellowAccent,
                               onPressed: (){},
                             ),

                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
               ],
            ),
          ),
        ),
      ),
    );
  }
}

class memory extends StatefulWidget {
  const memory({Key key}) : super(key: key);

  @override
  _memoryState createState() => _memoryState();
}

class _memoryState extends State<memory> {
  Future<File> imagefile;

  pickimagefromgallery(ImageSource source){
   setState(() {
     imagefile=ImagePicker.pickImage(source: source);
   });
  }
  Widget showimage(){
    return FutureBuilder<File>(
      future: imagefile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot){
          if(snapshot.connectionState == ConnectionState.done&&
          snapshot.data != null){
            return Image.file(
              snapshot.data,
              width: 300,
              height: 300,
            );
          }else if(snapshot.error != null){
            return const Text(
              'error picking image',
               textAlign: TextAlign.center,
            );
          } else{
            return const Text(
                'No Image Selected',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
            );
          }
        },
     );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Center(child: Text("Iamges")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              showimage(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.blue,
                splashColor: Colors.greenAccent,
                child: Text("Select Image From Gallery",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    pickimagefromgallery(ImageSource.gallery);
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class calculator extends StatefulWidget {
  const calculator({Key key}) : super(key: key);

  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor){
    return Container(
       child: RaisedButton(
         onPressed: (){
           calculation(btntxt);
         },
         child: Text(btntxt,
         style: TextStyle(
          fontSize: 20,
          color: txtcolor,
         ),
         ),
         shape: CircleBorder(),
         color: btncolor,
         padding: EdgeInsets.all(20),
       ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Center(
        child: Text("Calculator", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.lightGreenAccent,

        ),
        ),
      ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                    fontSize: 75
                    ),
                    ),
                ),
              ],
            ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
                calcbutton('AC', Colors.cyanAccent, Colors.black),
               calcbutton('+/-', Colors.cyanAccent, Colors.black),
               calcbutton('%', Colors.cyanAccent, Colors.black),
               calcbutton('/', Colors.redAccent, Colors.white),
             ],
           ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('7', Colors.cyanAccent, Colors.black),
                calcbutton('8', Colors.cyanAccent, Colors.black),
                calcbutton('9', Colors.cyanAccent, Colors.black),
                calcbutton('x', Colors.redAccent, Colors.white),
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('4', Colors.cyanAccent, Colors.black),
                calcbutton('5', Colors.cyanAccent, Colors.black),
                calcbutton('6', Colors.cyanAccent, Colors.black),
                calcbutton('-', Colors.redAccent, Colors.white),
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('1', Colors.cyanAccent, Colors.black),
                calcbutton('2', Colors.cyanAccent, Colors.black),
                calcbutton('3 ', Colors.cyanAccent, Colors.black),
                calcbutton('+', Colors.redAccent, Colors.white),
              ],
            ),
            SizedBox(height: 8,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(20, 12, 120, 8),
                  onPressed: (){
                    calculation('0');
                  },
                  shape: StadiumBorder(),
                  child: Text("0",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  ),
                  ),
                  color: Colors.cyanAccent,
                ),
                calcbutton('.', Colors.cyanAccent, Colors.black),
                calcbutton('=', Colors.greenAccent, Colors.white),

              ],
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}













