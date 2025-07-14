class CardModel {//Sync to Online
  final int? id;
  final String? uid;
  final String? uidCreator;
  final String? subscriber;
  final String? SyncAdd;
  final String? SyncUpdate;
  final String? created_at;
  final String? updated_at;



  CardModel({
    this.id,
    this.uid,
    this.uidCreator,
    this.subscriber,
    this.SyncAdd,
    this.SyncUpdate,
    this.created_at,
    this.updated_at,



  });

  factory CardModel.fromMap(Map<String, dynamic> json) => new CardModel(
    id: json['id'],
    uid: json['uid'],
    uidCreator: json['uidCreator'],
    subscriber:json['subscriber'],
    SyncAdd:json['SyncAdd'],
    SyncUpdate:json['SyncUpdate'],
    created_at:json['created_at'],
    updated_at:json['updated_at'],

  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'uidCreator': uidCreator,
      'subscriber': subscriber,
      'SyncAdd': SyncAdd,
      'SyncUpdate': SyncUpdate,
      'created_at': created_at,
      'updated_at': updated_at



    };
  }
}
