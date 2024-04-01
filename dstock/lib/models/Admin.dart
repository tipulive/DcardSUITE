class Admin {
  final int? id;
  final String uid;
  final String? photo_url;
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? Ccode;
  final String? platform;
  final String? CompanyName;
  final String? AuthToken;
  final String? status;
  final String? subscriber;
  final String? initCountry;
  final String? country;

  final String? created_at;
  final String? updated_at;


  Admin({
    this.id,
    required this.uid,
    this.photo_url,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.Ccode,
    this.platform,
    this.CompanyName,
    this.AuthToken,
    this.status,
    required this.subscriber,
    this.initCountry,
    this.country,

    this.created_at,
    this.updated_at

  });

  factory Admin.fromMap(Map<String, dynamic> json) => new Admin(
      id: json['id'],
      uid: json['uid'],
      photo_url: json['photo_url'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      Ccode: json['Ccode'],
      platform: json['platform'],
      CompanyName: json['CompanyName'],
      AuthToken: json['AuthToken'],
      status: json['status'],
      subscriber: json['subscriber'],
      initCountry: json['initCountry'],
      country: json['country'],

      created_at: json['created_at'],
      updated_at: json['updated_at']
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'photo_url': photo_url,
      'name': name,
      'email':email,
      'password':password,
      'phone':phone,
      'Ccode':Ccode,
      'platform':platform,
      'CompanyName':CompanyName,
      'AuthToken':AuthToken,
      'status':status,
      'subscriber':subscriber,
      'initCountry':initCountry,
      'country':country,

      'created_at': created_at,
      'updated_at': updated_at

    };
  }
}