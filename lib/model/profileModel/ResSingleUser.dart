class ResSingleUser {
 late Location location;
 late Ssn ssn;
 late String? sId;
 late String? fullName;
 late String? email;
 late bool? isVerfied;
 late String? password;
 late String? phone;
 late String? image;
 late String? role;
 late String? position;
 late bool? isDeleted;
 late bool? isDeletedRequest;
 late bool? isDeletedSuper;
 late bool? isAgreed;
 late String? dob;
 late String? lastUpdated;
 late String? createdOn;
 late int? iV;

  ResSingleUser(
      {required this.location,
      required this.ssn,
      required this.sId,
      required this.fullName,
      required this.email,
      required this.isVerfied,
      required this.password,
      required this.phone,
      required this.image,
      required this.role,
      required this.position,
      required this.isDeleted,
      required this.isDeletedRequest,
      required this.isDeletedSuper,
      required this.isAgreed,
      required this.dob,
      required this.lastUpdated,
      required this.createdOn,
      required this.iV});

  ResSingleUser.fromJson(Map<String, dynamic> json) {
    location = (json['location'] != null
        ? new Location.fromJson(json['location'])
        : null)!;
    ssn = (json['ssn'] != null ? new Ssn.fromJson(json['ssn']) : null)!;
    sId = json['_id'];
    fullName = json['full_name'];
    email = json['email'];
    isVerfied = json['is_verfied'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
    role = json['role'];
    position = json['position'];
    isDeleted = json['is_deleted'];
    isDeletedRequest = json['is_deleted_request'];
    isDeletedSuper = json['is_deleted_super'];
    isAgreed = json['is_agreed'];
    dob = json['dob'];
    lastUpdated = json['last_updated'];
    createdOn = json['created_on'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.ssn != null) {
      data['ssn'] = this.ssn!.toJson();
    }
    data['_id'] = this.sId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['is_verfied'] = this.isVerfied;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['role'] = this.role;
    data['position'] = this.position;
    data['is_deleted'] = this.isDeleted;
    data['is_deleted_request'] = this.isDeletedRequest;
    data['is_deleted_super'] = this.isDeletedSuper;
    data['is_agreed'] = this.isAgreed;
    data['dob'] = this.dob;
    data['last_updated'] = this.lastUpdated;
    data['created_on'] = this.createdOn;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
 late String? address;
 late String? country;
 late String? city;
 late String? state;
 late String? postalcode;

  Location(
      {required this.address, required this.country, required this.city, required this.state, required this.postalcode});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    postalcode = json['postalcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalcode'] = this.postalcode;
    return data;
  }
}

class Ssn {
  late String? ssnNumber;
  late String? ssnUpload;

  Ssn({required this.ssnNumber, required this.ssnUpload});

  Ssn.fromJson(Map<String, dynamic> json) {
    ssnNumber = json['ssn_number'];
    ssnUpload = json['ssn_upload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ssn_number'] = this.ssnNumber;
    data['ssn_upload'] = this.ssnUpload;
    return data;
  }
}
