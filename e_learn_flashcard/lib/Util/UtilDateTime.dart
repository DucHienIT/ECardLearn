import 'package:intl/intl.dart';

String getCurrentDate() {
  // Sử dụng đối tượng DateTime để lấy ngày hiện tại
  DateTime now = DateTime.now();

  // Sử dụng thư viện intl để định dạng ngày theo yêu cầu
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);

  return formattedDate;
}
