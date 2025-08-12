
class StudentDetailsModel {
  final String name;
  final String imageUrl;
  final double attendanceRate;
  final int oralMark;
   bool isFavorite;

  StudentDetailsModel({
    required this.name,
    required this.imageUrl,
    required this.attendanceRate,
    required this.oralMark,
    this.isFavorite = false,
  });
}