import 'package:flutter/material.dart';

class ProgressAlertDialog extends StatefulWidget {
  final ProgressAlertDialogState _state = ProgressAlertDialogState();

  ProgressAlertDialog({Key key}) : super(key: key);

  void updatePercentProgress(double newValue) {
    _state.updatePercentProgress(newValue);
  }

  @override
  ProgressAlertDialogState createState() => _state;
}

class ProgressAlertDialogState extends State<ProgressAlertDialog> {
  double _percentProgress = 0;

  void updatePercentProgress(double newValor) {
    setState(() {
      _percentProgress = newValor;
    });
  }

  int humanPercent(progress) => ((progress ?? 0) * 100).round();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${humanPercent(_percentProgress)}% das imagens processadas'),
      content: Container(
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Preparando assets, isso pode levar alguns segundos...'),
              LinearProgressIndicator(
                backgroundColor: Color(0xFFFC4A1A),
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Color(0xFFF7B733),
                ),
                value: _percentProgress ?? 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
