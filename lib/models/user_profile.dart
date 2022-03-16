// ignore_for_file: non_constant_identifier_names



class UserProfile {
  Address? address;
  dynamic email;
  Name? name;
  dynamic password;
  dynamic phone;
  dynamic username;
  dynamic uId;

  UserProfile(this.address, this.email, this.name, this.password, this.phone, this.username,uId);
  UserProfile.fromJson(Map<dynamic, dynamic>? json) {
    address= json!['address'] != null ? Address.fromJson(json['address']) : null;
    email= json['email'];
    name= json['name'] != null ? Name.fromJson(json['name']) : null;
    password= json['password'];
    phone= json['phone'];
    username= json['username'];
    uId=json['uId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['username'] = username;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['uId']=uId;
    return data;
  }
}

class Name {
  dynamic firstname;
  dynamic lastname;

  Name({this.firstname, this.lastname});

  Name.fromJson(Map<String, dynamic> json) {
    firstname= json['firstname'];
    lastname= json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}

class Address {
  dynamic city;
  Geolocation? geolocation;
  dynamic number;
  dynamic street;
  dynamic zipcode;

  Address({this.city, this.geolocation, this.number, this.street, this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    city= json['city'];
    geolocation= json['geolocation'] != null ? Geolocation.fromJson(json['geolocation']) : null;
    number= json['number'];
    street= json['street'];
    zipcode= json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['number'] = number;
    data['street'] = street;
    data['zipcode'] = zipcode;
    if (geolocation != null) {
      data['geolocation'] = geolocation!.toJson();
    }
    return data;
  }
}

class Geolocation {
  dynamic lat;
  dynamic long;

  Geolocation({this.lat, this.long});

  Geolocation.fromJson(Map<String, dynamic> json) {
    lat= json['lat'];
    long= json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}