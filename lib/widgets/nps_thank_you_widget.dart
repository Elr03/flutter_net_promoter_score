import 'package:flutter/material.dart';
import 'package:flutter_net_promoter_score/model/nps_survey_texts.dart';

class NpsThankYouWidget extends StatefulWidget {
  final NpsThankYouPageTexts texts;
  final NpsThankYouPageButtons? buttons;
  final int? score;
  final Widget? thankYouIcon;

  get showButtons =>
      buttons != null &&
      score != null &&
      score! > buttons!.showButtonsWhenRatingAtLeast;

  NpsThankYouWidget({
    super.key,
    required this.texts,
    required this.score,
    this.thankYouIcon,
    this.buttons,
  });

  @override
  NpsThankYouWidgetState createState() => new NpsThankYouWidgetState();
}

class NpsThankYouWidgetState extends State<NpsThankYouWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
            ],
          ),
          Container(
            child: FittedBox(
              child: this.widget.thankYouIcon == null
                  ? Icon(Icons.done)
                  : this.widget.thankYouIcon,
              fit: BoxFit.fill,
            ),
            width: 80,
            height: 80,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            this.widget.showButtons
                ? this.widget.texts.thankYouButtonsLabelText
                : this.widget.texts.thankYouLabelText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          if (this.widget.showButtons)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: this.widget.buttons!.thankYouButtonCancelStyle,
                    child: this.widget.buttons!.thankYouButtonCancelContent,
                  ),
                  TextButton(
                    onPressed: () => {
                      this.widget.buttons!.thankYouButtonAction(),
                      Navigator.pop(context)
                    },
                    style: this.widget.buttons!.thankYouButtonStyle,
                    child: this.widget.buttons!.thankYouButtonContent,
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
    );
  }
}
