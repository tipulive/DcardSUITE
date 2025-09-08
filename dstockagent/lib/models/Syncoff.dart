class Syncoff {//Sync to Online
  final int? id;
  final String? uid;
  final String? versionCount;
  final String? subscriber;
  final String? actionName;
  final String? tableName;
  final String? VersionOnline;



  Syncoff({
    this.id,
    this.uid,
    this.versionCount,
    this.subscriber,
    this.actionName,
    this.tableName,
    this.VersionOnline,



  });

  factory Syncoff.fromMap(Map<String, dynamic> json) => new Syncoff(
    id: json['id'],
    uid: json['uid'],
    versionCount: json['versionCount'],
    subscriber:json['subscriber'],
    actionName:json['actionName'],
    tableName:json['tableName'],
    VersionOnline:json['VersionOnline']

  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'versionCount': versionCount,
      'subscriber': subscriber,
      'actionName': actionName,
      'tableName': tableName,
      'VersionOnline': VersionOnline



    };
  }
}