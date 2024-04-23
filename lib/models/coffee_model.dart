class Coffee {
  String? employeeName;
  String? type;
  bool? isHot;
  Coffee({this.employeeName, this.type, this.isHot});

  factory Coffee.fromJson(Map<String, dynamic> data) {
    final employeeName = data["name"];
    final type = data["type"];
    final isHot = data["isHot"];

    return Coffee(employeeName: employeeName, type: type, isHot: isHot);
  }

  Map<String, dynamic> toFireStoreJson() =>
      {"name": employeeName, "type": type, "isHot": isHot};
}
