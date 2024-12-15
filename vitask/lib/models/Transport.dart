class Transport {//Sync to Online
  final int? id;
  final String? uidTransport;
  final String? uidUser;
  final String? name;
  final String? phone;
  final String? origin;
  final String? destination;
  final String? seat;
  final String? searchOption;
  final String? commentData;
  final String? dateOn;
  final String? searchItem;




  Transport({
    this.id,
    this.uidTransport,
    this.uidUser,
    this.name,
    this.phone,
    this.origin,
    this.destination,
    this.seat,
    this.searchOption,
    this.commentData,
    this.dateOn,
    this.searchItem,



  });

  factory Transport.fromMap(Map<String, dynamic> json) => new Transport(
    id: json['id'],
    uidTransport: json['uidTransport'],
    uidUser: json['uidUser'],
    name: json['name'],
    phone:json['phone'],
    origin:json['origin'],
    destination:json['destination'],
    seat:json['seat'],
    searchOption:json['searchOption'],
    commentData:json['commentData'],
    dateOn:json['dateOn'],
    searchItem:json['searchItem'],

  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uidTransport':uidTransport,
      'uidUser':uidUser,
      'name':name,
      'phone':phone,
      'origin':origin,
      'destination':destination,
      'seat':seat,
      'searchOption':searchOption,
      'commentData':commentData,
      'dateOn':dateOn,
      'searchItem':searchItem




    };
  }
}