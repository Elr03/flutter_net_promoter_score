import 'package:flutter/material.dart';

class NpsSelectScoreWidget extends StatefulWidget {
  final Key key;
  final VoidCallback onSendButtonPressed;

  const NpsSelectScoreWidget({this.key, this.onSendButtonPressed});

  @override
  NpsSelectScoreWidgetState createState() => new NpsSelectScoreWidgetState();
}

class NpsSelectScoreWidgetState extends State<NpsSelectScoreWidget> {

  int _scoreValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "How likely are you to recommaned the XXX app to a ferind or colleague?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Slider(
            onChanged: (double value) {
              setState(() {
                _scoreValue = value.toInt();
              });
            },
            value: _scoreValue.toDouble(),
            min: 0.0,
            max: 10.0,
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              this.widget.onSendButtonPressed();
            },
            child: Text("SEND"),
            color: Colors.grey,
          )
        ],
      );
  }
}
