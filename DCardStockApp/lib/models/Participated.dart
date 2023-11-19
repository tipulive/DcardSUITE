class Participated {
  final int? id;
  final String? uid;
  final String? uidUser;
  final String? carduid;
  final String? uidCreator;
  final String? subscriber;
  final String? promotion_msg;
  final String? inputData;
  final String? token;
  final String? started_date;
  final String? ended_date;
  final String? status;
  final String? created_at;
  final String? updated_at;


  Participated({
    this.id,
    this.uid,
    this.uidUser,
    this.carduid,
    this.uidCreator,
    this.subscriber,
    this.promotion_msg,
    this.inputData,
    this.token,
    this.started_date,
    this.ended_date,
    this.status,
    this.created_at,
    this.updated_at

  });

  factory Participated.fromMap(Map<String, dynamic> json) => new Participated(
      id: json['id'],
      uid: json['uid'],
      uidUser: json['uidUser'],
      carduid: json['carduid'],
      uidCreator:json['uidCreator'],
      subscriber:json['subscriber'],
      promotion_msg: json['promotion_msg'],
      inputData: json['inputData'],
      token: json['token'],
      started_date: json['started_date'],
      ended_date: json['ended_date'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at']
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'uidUser': uidUser,
      'carduid': carduid,
      'uidCreator':uidCreator,
      'subscriber':subscriber,
      'promotion_msg': promotion_msg,
      'inputData':inputData,
      'token': token,
      'started_date': started_date,
      'ended_date': ended_date,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at

    };
  }
}