import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:nexus_focus/utils/colors.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  late Duration _remainingTime;
  late Timer _timer;
  bool _isRunning = false;
  bool count = true;
  var msg = "Hora da ação!";

  @override
  void initState() {
    super.initState();
    _remainingTime = Duration(minutes: 25);
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });

    Future<void> _playAlarmSound() async {
      await _audioPlayer.play(UrlSource('assets/sounds/alarm.mp3'));
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime -= Duration(seconds: 1);
        } else {
          timer.cancel();
           count == true ? _remainingTime = Duration(minutes: 25) : _remainingTime = Duration(minutes: 5);
           count = !count;
          _playAlarmSound();
          setState(() {
            msg = "Agora, tire um tempinho :)";
            _isRunning = false;
          });
        }
      });
    });
  }

  void _pauseTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _toggleTimer() {
    if (_isRunning) {
      _pauseTimer();
    } else {
      _startTimer();
    }
  }

  Future<void> _editTimer() async {
    final newTime = await showDialog<Duration>(
      context: context,
      builder: (BuildContext context) {
        Duration selectedTime = _remainingTime;
        return AlertDialog(
          title: Text('Editar Timer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: TextEditingController(
                  text: selectedTime.inMinutes.toString(),
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Minutos'),
                onChanged: (value) {
                  selectedTime = Duration(minutes: int.tryParse(value) ?? 0);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedTime);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (newTime != null) {
      setState(() {
        _remainingTime = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Pomodoro',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: primaryColor
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    msg,
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    child: Center(
                      child: Text(
                        '${_remainingTime.inMinutes.toString().padLeft(2, '0')}:${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _editTimer, // Chama a função para editar o tempo
                    child: Text('Editar Timer'),
                  ),
                ),
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Center(
                    child: InkWell(
                      onTap: _toggleTimer,
                      borderRadius: BorderRadius.circular(75), // Tornar o botão redondo
                      splashColor: Colors.blueAccent, // Cor de fundo ao tocar
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isRunning ? Colors.black : primaryColor, // Cor do botão
                        ),
                        child: Center(
                          child: Icon(
                            _isRunning ? Icons.pause : Icons.play_arrow, // Ícone de pause ou play
                            size: 60.0,
                            color: Colors.white, // Cor do ícone
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
