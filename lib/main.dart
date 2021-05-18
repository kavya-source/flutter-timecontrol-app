import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tb;
  int hour=0;
  int min=0;
  int sec=0;
  bool started=true;
  bool restarted=true;
  bool paused=true;
  int timeForTimer =0;
  String timeToDisplay=" ";
  bool checkTimer=true;
  bool checkToReset =true;
  bool sStarted=true;
  bool sStopped=true;
  bool checkTime =true;
  String displayTime = " ";
  int timeForStopwatch = 1;
  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }
  void start(){
    setState(() {
      started = false;
      restarted = false;
      paused = false;
    });
  timeForTimer=((hour*60*60)+(min*60)+(sec));
  Timer.periodic(Duration(
    seconds:1,
  ),(Timer t){
   setState(() {
     if(timeForTimer<1 || checkTimer==false){
       t.cancel();
       if(timeForTimer==0){
         timeToDisplay="Oops!Time Over";

       }
       //else if(checkToReset==false){

       //checkTimer=true;
       //timeToDisplay= " ";
       //started=true;
       //stopped=true; //these 4 lines are taken care by the navigator(next step) also re-setting to 00:00:00
       //Navigator.pushReplacement(context, MaterialPageRoute(
         //builder: (context) => HomePage()
       //));
     //}
     }
     else if(timeForTimer<60){
       timeToDisplay = timeForTimer.toString();
       timeForTimer=timeForTimer-1;
     }
     else if(timeForTimer<3600){
       int m = timeForTimer~/60;
       int s = timeForTimer - (60*m);
       timeToDisplay=m.toString() + ":" + s.toString();
       timeForTimer=timeForTimer-1;
     }
     else{
       int h = timeForTimer~/3600;
       int t = timeForTimer - (3600*h);
       int m = t~/60;
       int s = t- (60*m);
       timeToDisplay= h.toString()+":"+m.toString()+":"+s.toString();
       timeForTimer=timeForTimer-1;
     }

   });
  });
  }
  void restart(){
   setState(() {
     started=true;
     restarted=true;
     paused =true;
     checkTimer=false;
     Navigator.pushReplacement(context, MaterialPageRoute(
         builder: (context) => HomePage()
     ));
     //checkToReset=false;
   });
  }
  void pause(){
    setState(() {
      started=false;
      restarted=false;
      paused= true;
      checkTimer=false;
      timeToDisplay=timeForTimer.toString();

    });
  }
  Widget timer(){
    return Container(
      child: Column(  //child under timer
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(   //child under timer under the first part(6 sections)
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(   //the first column (hh) under timer under first part under HH
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text("HH",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,))
                    ),
                    NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val){
                         setState(() {
                           hour = val;
                         });
                        },
                    ),
                  ],
                ),
                Column(   //similarly under MM
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text("MM",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,))
                    ),
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 59,
                        listViewWidth: 60.0,
                        onChanged: (val){
                          setState(() {
                            min = val;
                          });
                        })
                  ],
                ),
                Column(   //similarly under SS
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text("SS",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ))
                    ),
                    NumberPicker.integer(initialValue:sec, minValue: 0, maxValue: 59,
                        listViewWidth: 60.0,
                        onChanged: (val){
                          setState(() {
                            sec = val;
                          });
                        })
                  ],
                )
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Text(
            timeToDisplay,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w600,
            ))
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                    onPressed:started ? start : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0,
                    ),
                    color: Colors.green,
                    hoverElevation: 10.0,
                    child: Text("Start",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    ),
                RaisedButton(
                    onPressed: restarted ? null : restart,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0,
                    ),
                  color: Colors.yellow,
                  hoverElevation: 10.0,
                    child: Text("Restart",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    )),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                RaisedButton(
                  onPressed: paused ? null: pause,
                  padding: EdgeInsets.symmetric(
                    horizontal:40.0,
                    vertical: 10.0,
                  ),
                  color: Colors.red,
                  hoverElevation: 10.0,
                  child: Text("Pause",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,

                  ),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                )
              ],
            )
          ),
        ],
      )
    );
  }
  void sStart() {
    setState(() {
      sStarted = false;
      sStopped = false;
    });


    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer s) {
      setState(() {
        if(checkTime==false){
          s.cancel();
          Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage()
          ));

        }
        else if (timeForStopwatch < 60) {
          displayTime = timeForStopwatch.toString();
          timeForStopwatch = timeForStopwatch + 1;
        }
        else if (timeForStopwatch < 3600) {
          int m = timeForStopwatch ~/ 60;
          int s = timeForStopwatch - (m * 60);
          displayTime = m.toString() + ":" + s.toString();
          timeForStopwatch = timeForStopwatch + 1;
        }
        else {
          int h = timeForStopwatch ~/ 3600;
          int t = timeForStopwatch - (h * 3600);
          int mm = t ~/ 60;
          int ss = (t - (mm * 60));
        }
      });
    });
  }

  void sStop(){
    setState(() {
      sStarted=true;
      sStopped=true;
      checkTime=false;
      //Navigator.pushReplacement(context, MaterialPageRoute(
          //builder: (context) => HomePage()
      //));
    });

  }
  Widget stopWatch(){ //if not can make use of Stopwatch(),inbuilt function which has inbuilt start,reset,stop options
                      //assigning a variable to the Stopwatch() and making slight changes in this code!
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
        Expanded(
         flex: 6,
          child: Row(   //child under timer under the first part(6 sections)
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
           Text(displayTime,
            style:TextStyle(
             fontSize: 100.0,
             fontWeight: FontWeight.bold,
            )
           ),
          ]),
      ),

          Expanded(
            flex: 5,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: sStarted ? sStart : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                    ),
              color: Colors.green,
              hoverColor:Colors.lightGreen ,
                 child: Text("Start",
                 style: TextStyle(
                   fontSize: 18.0,
                   color: Colors.white70,
                 ),
                  ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),

                ),
                ),

                RaisedButton(
                 onPressed: sStopped ? null : sStop,
                 padding: EdgeInsets.symmetric(
                   horizontal: 40.0,
                   vertical: 20.0,
                 ),
                 color: Colors.red,
                 hoverColor: Colors.orange,
                 child: Text("Stop",
                 style: TextStyle(
                   fontSize: 18.0,
                   color:Colors.white70,
                 ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                ),
              ],
            )
          )
    ]));



}
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Control"),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text("Timer",),
            Text("StopWatch",),
          ],
          labelPadding: EdgeInsets.only(
            bottom: 10.0
          ),
          labelStyle: TextStyle(
           fontSize: 18.0
          ),
          unselectedLabelColor: Colors.white54,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopWatch(),
    ],
    controller: tb,
    )

    );
  }
}
