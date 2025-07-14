class User {
  final int? id;
  final String uid;
  final String? carduid;
  final String? uidCreator;
  final String? gender;
  final String? age;
  final String? marital_status;
  final String? remember_token;
  final String? photo_url;
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? platform;
  final String? status;
  final String? subscriber;
  final String? country;

  final String? created_at;
  final String? updated_at;


  User({
    this.id,
    required this.uid,
    this.carduid,
    this.uidCreator,
    this.gender,
    this.age,
    this.marital_status,
    this.remember_token,
    this.photo_url,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.platform,
    this.status,
    this.subscriber,
    this.country,

    this.created_at,
    this.updated_at

  });

  factory User.fromMap(Map<String, dynamic> json) => new User(
      id: json['id'],
      uid: json['uid'],
      carduid: json['carduid'],
      uidCreator: json['uidCreator'],
      gender: json['gender'],
      age: json['age'],
      marital_status: json['marital_status'],
      remember_token: json['remember_token'],
      photo_url: json['photo_url'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      platform: json['platform'],
      status: json['status'],
      subscriber: json['subscriber'],
      country: json['country'],

      created_at: json['created_at'],
      updated_at: json['updated_at']
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'carduid': carduid,
      'uidCreator':uidCreator,
      'gender':gender,
      'age':age,
      'marital_status':marital_status,
      'remember_token':remember_token,
      'photo_url':photo_url,
      'name': name,
      'email':email,
      'password':password,
      'phone':phone,
      'platform':platform,
      'status':status,
      'subscriber':subscriber,
      'country':country,

      'created_at': created_at,
      'updated_at': updated_at

    };
  }
}