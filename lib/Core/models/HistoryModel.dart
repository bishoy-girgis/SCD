class HistoryModel {
  HistoryModel({
      this.id, 
      this.timestamp, 
      this.diagnose, 
      this.image,});

  HistoryModel.fromJson(dynamic json) {
    id = json['id'];
    timestamp = json['timestamp'];
    diagnose = json['diagnose'];
    image = json['image'];
  }
  int? id;
  String? timestamp;
  String? diagnose;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['timestamp'] = timestamp;
    map['diagnose'] = diagnose;
    map['image'] = image;
    return map;
  }
  static List<HistoryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HistoryModel.fromJson(json)).toList();
  }

}