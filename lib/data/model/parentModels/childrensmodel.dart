class ChildrenModel {
  int? childrenId;
  String? childrenName;
  String? imageUrl;
  String? email;
  int? parentId;
  String? parentName;
  String? parentPhone;
  int? teacherId;
  int? driverId;
  String? driverName;
  String? teacherName;
  String? schoolName;
  String? schoolLat;
  String? schoolLong;
  String? className;
  String? schoolClassDivision;

  ChildrenModel(
      {this.childrenId,
      this.childrenName,
      this.imageUrl,
      this.email,
      this.parentId,
      this.parentName,
      this.parentPhone,
      this.teacherId,
      this.driverId,
      this.driverName,
      this.teacherName,
      this.schoolName,
      this.schoolLat,
      this.schoolLong,
      this.className,
      this.schoolClassDivision});

  ChildrenModel.fromJson(Map<String, dynamic> json) {
    childrenId = json['children_id'];
    childrenName = json['children_name'];
    imageUrl = json['image_url'];
    email = json['email'];
    parentId = json['parent_id'];
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    parentName = json['parent_name'];
    parentPhone = json['parent_phone'];
    teacherId = json['teacher_id'];
    teacherName = json['teacher_name'];
    schoolName = json['school_name'];
    schoolLat = json['school_latitude'];
    schoolLong = json['school_longitude'];
    className = json['class_name'];
    schoolClassDivision = json['school_class_division'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['children_id'] = childrenId;
    data['children_name'] = childrenName;
    data['image_url'] = imageUrl;
    data['email'] = email;
    data['parent_id'] = parentId;
    data['parent_name'] = parentName;
    data['parent_phone'] = parentPhone;
    data['teacher_id'] = teacherId;
    data['driver_id'] = driverId;
    data['driver_name'] = driverName;
    data['teacher_name'] = teacherName;
    data['school_name'] = schoolName;
    data['school_latitude'] = schoolLat;
    data['school_longitude'] = schoolLong;
    data['class_name'] = className;
    data['school_class_division'] = schoolClassDivision;
    return data;
  }
}
