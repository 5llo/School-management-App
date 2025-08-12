class Weekmodel {
  final String date;
  final String time;
  final String subject;

  Weekmodel({required this.date, required this.time, required this.subject});

factory Weekmodel.fromJson(Map<String, dynamic> json) {
  return Weekmodel(
    date: json['date'] ?? '',
    time: json['time'] ?? '',
    subject: json['subject'] ?? '',
  );
}
String toString() {
    return '📚 Subject: $subject | 🕒 Time: $time | 📅 Date: $date';
  }
}