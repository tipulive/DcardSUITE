class Topups {
  final int? id;
  final String ?uid;

  final String ?uidCreator;
  final String? amount;
  final String ?subscriber;
  final String ?purpose;
  final String ?desc;
  final int ?startlimit;
  final int ?endlimit;
  final String?optionCase;


  final String ?created_at;
  final String ?updated_at;


  Topups({
    this.id,
     this.uid,

    this.uidCreator,
    this.amount,
    this.subscriber,
    this.purpose,
    this.desc,
    this.startlimit,
    this.endlimit,
    this.optionCase,

    this.created_at,
    this.updated_at

  });

  factory Topups.fromMap(Map<String, dynamic> json) => new Topups(
      id:json['id'],
      uid:json['uid'],

      uidCreator:json['uidCreator'],
      amount:json['amount'],
      subscriber:json['subscriber'],
      purpose:json['purpose'],
      desc:json['desc'],
      startlimit:json['startlimit'],
      endlimit:json['endlimit'],
      optionCase:json['optionCase'],

      created_at:json['created_at'],
      updated_at:json['updated_at']
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid':uid,

      'uidCreator':uidCreator,
      'amount': amount,
      'subscriber': subscriber,
      'purpose': purpose,
      'desc': desc,
      'startlimit':startlimit,
      'endlimit':endlimit,
      'optionCase':optionCase,
      'created_at': created_at,
      'updated_at': updated_at

    };
  }
}