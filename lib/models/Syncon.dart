class Syncon {//Sync to Online
  final int? id;
  final String? uid;
  Map<String,dynamic> result;
  final String? versionCount;
  final String? subscriber;
  final String? actionName;
  final String? tableName;



  Syncon({
    this.id,
    this.uid,
    required this.result,
    this.versionCount,
    this.subscriber,
    this.actionName,
    this.tableName,



  });

  factory Syncon.fromMap(Map<String, dynamic> json) => new Syncon(
    id: json['id'],
    uid: json['uid'],
    result: json['result'],
    versionCount: json['versionCount'],
    subscriber:json['subscriber'],
    actionName:json['actionName'],
    tableName:json['tableName'],

  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'result': result,
      'versionCount': versionCount,
      'subscriber': subscriber,
      'actionName': actionName,
      'tableName': tableName



    };
  }
}