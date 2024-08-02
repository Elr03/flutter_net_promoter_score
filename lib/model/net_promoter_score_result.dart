import 'package:flutter_net_promoter_score/model/promoter_type.dart';

class NetPromoterScoreResult {
  int? score;
  String feedback = "";
  bool buttonsShown = false;
  PromoterType promoterType = PromoterType.unknown;
}
