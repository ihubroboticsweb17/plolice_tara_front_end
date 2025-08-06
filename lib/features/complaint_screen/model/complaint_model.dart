class ComplaintModel {
  int? count;
  String? next;
  String? previous;
  Results? results;

  ComplaintModel({this.count, this.next, this.previous, this.results});

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results = json['results'] != null
        ? new Results.fromJson(json['results'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  String? status;
  String? message;
  List<Data>? data;

  Results({this.status, this.message, this.data});

  Results.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? caseId;
  String? name;
  int? age;
  String? state;
  String? district;
  String? pincode;
  String? address;
  String? phoneNo;
  String? email;
  String? complaint;
  String? createdAt;
  int? user;

  Data({
    this.id,
    this.caseId,
    this.name,
    this.age,
    this.state,
    this.district,
    this.pincode,
    this.address,
    this.phoneNo,
    this.email,
    this.complaint,
    this.createdAt,
    this.user,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caseId = json['case_id'];
    name = json['name'];
    age = json['age'];
    state = json['state'];
    district = json['district'];
    pincode = json['pincode'];
    address = json['address'];
    phoneNo = json['phone_no'];
    email = json['email'];
    complaint = json['complaint'];
    createdAt = json['created_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['case_id'] = this.caseId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['state'] = this.state;
    data['district'] = this.district;
    data['pincode'] = this.pincode;
    data['address'] = this.address;
    data['phone_no'] = this.phoneNo;
    data['email'] = this.email;
    data['complaint'] = this.complaint;
    data['created_at'] = this.createdAt;
    data['user'] = this.user;
    return data;
  }
}
