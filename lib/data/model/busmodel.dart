
class BusModel {
  String? studentName;
  String? parentPhone;
  String? latitude;
  String? longitude;

  BusModel({this.studentName, this.parentPhone, this.latitude, this.longitude});

  BusModel.fromJson(Map<String, dynamic> json) {
    studentName = json['student_name'];
    parentPhone = json['parent_phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_name'] = studentName;
    data['parent_phone'] = parentPhone;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
