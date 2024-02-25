import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('d MMM, yyyy');
  return formatter.format(dateTime);
}