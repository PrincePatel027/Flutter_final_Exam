class DbModel {
  String name;
  String time;

  DbModel({required this.name, required this.time});

  factory DbModel.fromMap({required Map map}) {
    return DbModel(name: map['name'], time: map['time']);
  }
}
