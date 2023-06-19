import 'dart:convert';

class Corredor {
  int? id;
  String name;
  String time;
  String position;
  String bibnumber;
  String? photofinish;

  Corredor({
    this.id,
    required this.name,
    required this.time,
    required this.position,
    required this.bibnumber,
    this.photofinish,
  });

  factory Corredor.fromJson(String str) => Corredor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Corredor.fromMap(Map<String, dynamic> json) => Corredor(
        id: json["id"],
        name: json["name"],
        time: json["time"],
        position: json["position"],
        bibnumber: json["bibnumber"],
        photofinish: json["photofinish"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "time": time,
        "position": position,
        "bibnumber": bibnumber,
        "photofinish": photofinish,
      };
}
