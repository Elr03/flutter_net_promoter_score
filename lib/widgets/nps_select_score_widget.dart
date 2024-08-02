import 'package:flutter/material.dart';
import 'package:flutter_score_slider/flutter_score_slider.dart';
import 'package:flutter_net_promoter_score/model/nps_survey_texts.dart';
import 'package:flutter_net_promoter_score/model/promoter_type.dart';

class NpsSelectScoreWidget extends StatefulWidget {
  final int? score;
  final VoidCallback? onClosePressed;
  final VoidCallback? onSendButtonPressed;
  final void Function(int score)? onScoreChanged;
  final NpsSelectScorePageTexts texts;

  NpsSelectScoreWidget({
    super.key,
    required this.texts,
    this.onSendButtonPressed,
    this.onClosePressed,
    this.onScoreChanged,
    this.score,
  });

  @override
  NpsSelectScoreWidgetState createState() => new NpsSelectScoreWidgetState();
}

class NpsSelectScoreWidgetState extends State<NpsSelectScoreWidget> {
  int? _currentScore;

  @override
  void initState() {
    super.initState();
    _currentScore = this.widget.score ?? 0;
  }

  List<Widget> _numbers() {
    List<Widget> numbers = [];

    for (var currentScoreNumber = 0;
        currentScoreNumber <= 10;
        currentScoreNumber++) {
      numbers.add(
        Expanded(
          child: Container(
            child: Center(
              child: Text(
                currentScoreNumber.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: currentScoreNumber == _currentScore
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: currentScoreNumber == _currentScore
                          ? Theme.of(context).indicatorColor
                          : Theme.of(context).textTheme.bodyLarge?.color,
                    ),
              ),
            ),
            color: Colors.transparent,
          ),
        ),
      );
    }

    return numbers;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new SizedBox(
                height: 22.0,
                width: 22.0,
                child: new IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: new EdgeInsets.all(0.0),
                    icon: new Icon(Icons.close, size: 22.0),
                    onPressed: () {
                      if (this.widget.onClosePressed != null)
                        this.widget.onClosePressed!();
                    }),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.widget.texts.surveyQuestionText,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: _numbers(),
          ),
          SizedBox(
            height: 5,
          ),
          ScoreSlider(
            maxScore: 10,
            minScore: 0,
            height: 35,
            score: _currentScore,
            onScoreChanged: (int newScore) {
              setState(() => _currentScore = newScore);
              if (this.widget.onScoreChanged != null && _currentScore != null) {
                this.widget.onScoreChanged!(_currentScore!);
              }
            },
            thumbColor: Theme.of(context).sliderTheme.thumbColor,
            backgroundColor: Theme.of(context).colorScheme.surface,
            scoreDotColor: Theme.of(context).sliderTheme.activeTickMarkColor,
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text(
                    this.widget.texts.detractorScoreLabelText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: _currentScore?.toPromoterType() ==
                                PromoterType.detractor
                            ? Theme.of(context).indicatorColor
                            : Theme.of(context).textTheme.bodySmall?.color),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    this.widget.texts.promoterScoreLabelText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: _currentScore?.toPromoterType() ==
                                PromoterType.promoter
                            ? Theme.of(context).indicatorColor
                            : Theme.of(context).textTheme.bodySmall?.color),
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ButtonTheme(
            minWidth: 150,
            height: 45,
            child: ElevatedButton(
              onPressed: this._currentScore ==
                      null // Enable the button only if the user selected score
                  ? null
                  : () {
                      if (this.widget.onSendButtonPressed != null)
                        this.widget.onSendButtonPressed!();
                    },
              child: Text(
                this.widget.texts.submitButtonText,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).buttonTheme.colorScheme?.primary,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
