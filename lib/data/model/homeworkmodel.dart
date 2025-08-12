class HomeworkModel {
  final String description;
  final String file;
  final String createdAt;
  final String? teacher;

  HomeworkModel({
    required this.description,
    required this.file,
    required this.createdAt,
    required this.teacher,
  });

  factory HomeworkModel.fromJson(Map<String, dynamic> json) {
    return HomeworkModel(
      description: json['description'],
      file: json['file'],
      createdAt: json['created_at'],
      teacher: json['teacher'], // أضفه هنا لأنك تستخدمه في الواجهة
    );
  }
}
