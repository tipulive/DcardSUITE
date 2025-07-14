class BonusModel {//Sync to Online
  final int? id;
  final String? uid;
  final String? uidUser;
  final String? quickUid;
  final String? productName;
  final String? qty;
  final String? price;
  final String? total;
  final String? status;
  final String? bonusType;
  final String? giftName;
  final String? giftPcs;
  final String? bonusValue;
  final String? totBonusValue;
  final String? description;
  final String? uidCreator;
  final String? subscriber;
  final String? created_at;
  final String? updated_at;



  BonusModel({
    this.id,
    this.uid,
    this.uidUser,
    this.quickUid,
    this.productName,
    this.qty,
    this.price,
    this.total,
    this.status,
    this.bonusType,
    this.giftName,
    this.giftPcs,
    this.bonusValue,
    this.totBonusValue,
    this.description,
    this.uidCreator,
    this.subscriber,
    this.created_at,
    this.updated_at



  });

  factory BonusModel.fromMap(Map<String, dynamic> json) => new BonusModel(
      id:json['id'],
      uid:json['uid'],
      uidUser:json['uidUser'],
      quickUid:json['quickUid'],
      productName:json['productName'],
      qty:json['qty'],
      price:json['price'],
      total:json['total'],
      status:json['status'],
      bonusType:json['bonusType'],
      giftName:json['giftName'],
      giftPcs:json['giftPcs'],
      bonusValue:json['bonusValue'],
      totBonusValue:json['totBonusValue'],
      description:json['description'],
      uidCreator:json['uidCreator'],
      subscriber:json['subscriber'],
      created_at:json['created_at'],
      updated_at:json['updated_at']

  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'uidUser':uidUser,
      'quickUid':quickUid,
      'productName':productName,
      'qty': qty,
      'price':price,
      'total':total,
      'status': status,
      'bonusType':bonusType,
      'giftName':giftName,
      'giftPcs':giftPcs,
      'bonusValue':bonusValue,
      'totBonusValue':totBonusValue,
      'description':description,
      'uidCreator':uidCreator,
      'subscriber':subscriber,
      'created_at': created_at,
      'updated_at': updated_at



    };
  }
}
