class Appointment {//Sync to Online
  final int? id;
  final String? uid;
  final String? codeb;
  final String? limitb;
  final String? limitCounter;
  final String? status;
  final String? startDate;
  final String? endDate;
  final String? onlineStatus;
  final String? codeStatus;
  final String? codeName;
  final String? commentData;
  final String? actionStatus;





  Appointment({
    this.id,
    this.uid,
    this.codeb,
    this.limitb,
    this.limitCounter,
    this.status,
    this.startDate,
    this.endDate,
    this.onlineStatus,
    this.codeStatus,
    this.codeName,
    this.commentData,
    this.actionStatus



  });

  factory Appointment.fromMap(Map<String, dynamic> json) => new Appointment(
      id: json['id'],
      uid: json['uid'],
      codeb: json['codeb'],
      limitb: json['limitb'],
      limitCounter: json['limitCounter'],
      status: json['status'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      onlineStatus: json['onlineStatus'],
      codeStatus: json['codeStatus'],
      codeName: json['codeName'],
      commentData: json['commentData'],
      actionStatus: json['actionStatus']


  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid':uid,
      'codeb':codeb,
      'limitb':limitb,
      'limitCounter':limitCounter,
      'status':status,
      'startDate':startDate,
      'endDate':endDate,
      'onlineStatus':onlineStatus,
      'codeStatus':codeStatus,
      'codeName':codeName,
      'commentData':commentData,
      'actionStatus':actionStatus





    };
  }
}
