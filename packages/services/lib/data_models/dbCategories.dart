

class DBCategories {
  int id;
  int indexCategory;
  String title;
  int time;
  String color;
  String icon;
  String type;
  int min;
  int max;

  DBCategories({
    required this.id,
    required this.indexCategory,
    required this.title,
    required this.time,
    required this.color,
    required this.icon,
    required this.type,
    required this.min,
    required this.max
  });

  factory DBCategories.fromMap(Map<String, dynamic> json) => DBCategories(
    id: json["id"] ?? 0,
    indexCategory: json["indexCategory"] ?? 0,
    title: json["title"] ?? "",
    time: json["time"] ?? 0,
    color: json["color"] ?? "",
    icon: json["icon"] ?? "",
    type: json["type"] ?? "",
    min: json["min"] ?? 0,
    max: json["max"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "indexCategory": indexCategory,
    "title": title,
    "time": time,
    "color": color,
    "icon": icon,
    "type": type,
    "min": min,
    "max": max,
  };
}