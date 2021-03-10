
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

void main() {
runApp(new StepsCounter());
} 

class StepsCounter extends StatefulWidget {
  @override
  _StepsCounterState createState() => _StepsCounterState();
}

class _StepsCounterState extends State<StepsCounter> {
  String _stepsCount = 'Unknown';
  String _activitystatus = 'Still';

  Stream<StepCount>  _stepscount;
  Stream<PedestrianStatus> _activity;


  @override
  void initState() {
    super.initState();
    stepsCounter();
  }

  void stepsCounter() {
    _activity = Pedometer.pedestrianStatusStream;
    _activity.listen(_onActivity,
        onError: _onactivityError, onDone: _onDone, cancelOnError: true);
    
    _stepscount = Pedometer.stepCountStream;
    _stepscount.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

   void _onActivity(PedestrianStatus event) {
    setState(() {
      _activitystatus = event.status;
    });
  }

  void _onactivityError(error) {
    print(' Activity StatusError: $error');
    setState(() {
      _activitystatus = 'Activity Status not Available';
    });
  }

  void _onData(StepCount event) {
    print(event);
    setState(() {
      _stepsCount = event.steps.toString();
    });
  }
  

  void reset() {
    setState(() {
      int stepsCount = 0;
      _stepsCount = "$stepsCount";
    });
  }

  void _onDone() {}

  void _onError(error) {
    print("Pedometer Error: $error");
  }

 


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Step Counter App'),
          backgroundColor: Colors.black54,
        ),

        body:Center(child: Container(
          
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 220.0),
              child:  Text('$_stepsCount',style: TextStyle(
                   fontSize: 20.0,

              ),),
              ),

              Padding(padding: EdgeInsets.all(20),
              child:  Text(_activitystatus,style: TextStyle(
                   fontSize: 20.0,

              ),),
              ),
             
            ],
          ),
                  
        )),
        
       
      ),
    );
  }
}
