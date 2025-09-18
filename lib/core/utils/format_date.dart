import 'package:intl/intl.dart';

String FormatDateByDMMMYYYY(DateTime date) {
  // Format date to "DD MMM, YYYY"
  return DateFormat("d MMM, yyyy").format(date);
}