import 'package:flutter/material.dart';
import 'package:fypmobile/src/components/LiveIndicator.dart';
import 'package:fypmobile/src/components/SnackBar.dart';
import 'package:fypmobile/src/components/StopButton.dart';
import 'package:fypmobile/src/components/StartButton.dart';
import 'package:fypmobile/src/MatchSummary.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:vibration/vibration.dart';
import 'dart:async';

const Color primaryColor = Color(0xFF000435);

class LiveScorePage extends StatefulWidget {
  final bool shouldShowUptime;
  final String? battingTeam;
  final String? bowlingTeam;
  LiveScorePage({required this.shouldShowUptime, required this.battingTeam, required this.bowlingTeam});


  @override
  _LiveScorePageState createState() => _LiveScorePageState(battingTeam: battingTeam, bowlingTeam: bowlingTeam);
}

class _LiveScorePageState extends State<LiveScorePage> {

  // Match Parameters
  final String? battingTeam;
  final String? bowlingTeam;
  //final String? currentBatsman;
  String _bowler = "Bowler A";
  String _batsman = "Batsman A";
  List<String> _currentOver = [];
  List<String> _previousOver = [];
  String numberofOvers = '0.0';
  int ballsInOver = 0;
  int _totalRuns = 0;
  int _ballsBowled = 0;


  _LiveScorePageState({required this.battingTeam, required this.bowlingTeam});


  // Environment State Parameters
  bool _isConnected = true;
  bool _isPaused = false;
  late Timer _timer;
  int _elapsedTime = 0;
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();

    if (widget.shouldShowUptime) {
      _startTimer();
    }


    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomSnackBar.show(
        context,
        message: "Match Started!",
        backgroundColor: Colors.green,
        icon: Icons.sports_cricket,
      );
    });

    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _subscription.cancel();
    super.dispose();
  }

  void _addRun(int runs) {
    if (_isPaused) {
      _notifyPausedState();
      return;
    }
    setState(() {
      if(ballsInOver >= 6)
      {
        _previousOver = List.from(_currentOver);
        _currentOver.clear();
        ballsInOver = 0;

      }

      _currentOver.add(runs.toString());
      _totalRuns += runs;
      ballsInOver++;
      _ballsBowled++;


      //calculate overs
      int over = _ballsBowled ~/ 6;   // Get integer part of the over
      String LHS = over.toString();
      int RHS_value=0;

      if(ballsInOver == 6)
        {
          RHS_value = 0;            // Set the decimal part
        }else{                      // to zero if the number of balls
        RHS_value = ballsInOver;    // in the over is equal to 6
      }

      String RHS = RHS_value.toString();
      numberofOvers = '$LHS.$RHS';
      // End Calculate Overs


    });
  }

  void _addSpecialBall(String type) {
    if (_isPaused) {
      _notifyPausedState();
      return;
    }
    setState(() {
      _currentOver.add(type);
    });
  }

  void _notifyPausedState() {
    CustomSnackBar.show(
      context,
      message: "Match is paused",
      backgroundColor: Colors.red,
      icon: Icons.info,
    );

    if (Vibration.hasVibrator() != null) {
      Vibration.vibrate(duration: 700);
    }
  }

  double _calculateRunRate() {
    return _ballsBowled > 0 ? (_totalRuns / (_ballsBowled / 6)) : 0.0;
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  // Exit Dialog Box
  Future<bool> _showExitConfirmationDialog() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exit Confirmation"),
        content: Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Close the dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MatchSummary(), // Replace MatchSummary with your actual class
                ),
              );
            },
            child: Text("Exit"),
          ),
        ],
      ),
    )) ??
        false;
  }


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          _elapsedTime++;
        });
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _resumeTimer() {
    _startTimer();
  }

  String _formatUptime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showExitConfirmationDialog,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Live Score Update',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
        ),


        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              // Online status Card
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LiveIndicator(
                      color: _isConnected ? Colors.green : Colors.red,
                      text: _isConnected ? "Live" : "Offline",
                    ),
                    if(widget.shouldShowUptime)
                      Text('Uptime : ${_formatUptime(_elapsedTime)}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),


              // Match Title Card
              Card(
                elevation: 1,
                child: Padding(padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$battingTeam vs $bowlingTeam',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                    )
                  ],
                ),
                ),
              ),


              // Match Details Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Batting Team: $battingTeam',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Bowler: $_bowler',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 25.0),
                          Text(
                            'Batting: $_batsman',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Current Over: ${_currentOver.join(' ')}',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Previous Over: ${_previousOver.join(' ')}',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Run Rate: ${_calculateRunRate().toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 8),
                      Text(
                        'Overs : $numberofOvers',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Runs: $_totalRuns',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildScoreButton("1 Run", () => _addRun(1)),
                          _buildScoreButton("2 Run", () => _addRun(2)),
                          _buildScoreButton("4 Run", () => _addRun(4)),
                          _buildScoreButton("6 Run", () => _addRun(6)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildScoreButton("Wide Ball", () => _addSpecialBall("W")),
                          _buildScoreButton("No Ball", () => _addSpecialBall("NB")),
                          _buildScoreButton("Free Hit", () => _addSpecialBall("FH")),
                          _buildScoreButton("Dot Ball", () => _addRun(0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),


              // Pause Button, Undo Button Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: _togglePause,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isPaused ? Colors.blueAccent : Colors.yellow,
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isPaused ? Icons.play_arrow : Icons.pause,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            _isPaused ? "Resume" : "Pause",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Undo Button
                  FloatingActionButton(onPressed: _showExitConfirmationDialog,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Icon(
                      Icons.settings_backup_restore_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Stop Button
              Center(
                child: StopButton(
                  onStopPressed: () => _showExitConfirmationDialog(),
                  buttonText: "Stop",
                  buttonColor: primaryColor,
                  buttonIcon: Icons.stop,
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        padding: const EdgeInsets.all(6),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      child: Text(label, textAlign: TextAlign.center),
    );
  }
}
