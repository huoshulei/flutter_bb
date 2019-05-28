class MessageEntity {
  int messageCount;
  String pushContent;
  String pushType;

  MessageEntity({this.messageCount, this.pushContent, this.pushType});

  MessageEntity.fromJson(Map<String, dynamic> json) {
    messageCount = json['messageCount'];
    pushContent = json['pushContent'];
    pushType = json['pushType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageCount'] = this.messageCount;
    data['pushContent'] = this.pushContent;
    data['pushType'] = this.pushType;
    return data;
  }
}

List<MessageEntity> messageListFormJson(dynamic json) {
  var list = (json ?? []) as List;
  var data = <MessageEntity>[];
  list.forEach((i) {
    data.add(MessageEntity.fromJson(i));
  });
  return data;
}
class ScoreEntity {
  int equipmentCount;
  int runEquipmentCount;
  int fraction;

  ScoreEntity({this.equipmentCount, this.runEquipmentCount, this.fraction});

  ScoreEntity.fromJson(Map<String, dynamic> json) {
    equipmentCount = json['equipmentCount'];
    runEquipmentCount = json['runEquipmentCount'];
    fraction = json['fraction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['equipmentCount'] = this.equipmentCount;
    data['runEquipmentCount'] = this.runEquipmentCount;
    data['fraction'] = this.fraction;
    return data;
  }
}
