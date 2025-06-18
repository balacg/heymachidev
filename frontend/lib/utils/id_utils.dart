// lib/utils/id_utils.dart

import 'package:intl/intl.dart';
import 'package:restaurant_addon/services/restaurant_api.dart';
import '../services/api.dart';

/// Generic token formatter
String formatToken(String typeCode, int seq, DateTime date) {
  final dateStr = DateFormat('ddMMyy').format(date);
  final seqStr = seq.toString().padLeft(4, '0');
  return '$typeCode-$seqStr-$dateStr';
}

Future<String> generateShortToken(String prefix) async {
  final now = DateTime.now();
  final nextSeq = await RestaurantApi.getNextTokenSequence(prefix); 
  return formatToken(prefix, nextSeq, now);
}