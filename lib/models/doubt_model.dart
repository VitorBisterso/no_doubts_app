import 'dart:convert';

class Doubt {
  String doubt;
  String answer;
  String topic;

  Doubt({
    this.doubt,
    this.answer,
    this.topic,
  });

  factory Doubt.fromJson(Map<String, dynamic> json) => new Doubt(
    doubt: json["doubt"],
    answer: json["answer"],
    topic: json["topic"],
  );

  Map<String, dynamic> toJson() => {
    "doubt": doubt,
    "answer": answer,
    "topic": topic,
  };
}

doubtsFromJson(String str) {
  final jsonData = json.decode(str);
  return jsonData.map((value) => Doubt.fromJson(value));
}

Doubt doubtFromJson(String str) {
  final jsonData = json.decode(str);
  return Doubt.fromJson(jsonData);
}

String doubtToJson(Doubt data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}