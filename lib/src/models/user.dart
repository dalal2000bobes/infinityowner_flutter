import '../helpers/custom_trace.dart';

class Userss {
  String id;
  String name;
  String email;
  String token;
  String image;
  double lat;
  double long;
  String role;
  int timesTamp;
  int phone;

  Userss({
    this.token,
    this.lat,
    this.long,
    this.role,
    this.phone,
    this.image,
    this.email,
    this.id,
    this.timesTamp,
    this.name,
  });

  // ignore: non_constant_identifier_names
  void UserssLogin(String id,String email)
  {this.id=id; this.email=email;}


  // ignore: non_constant_identifier_names
  Userss UserSet(Userss userss)
  {return userss;}


  // ignore: non_constant_identifier_names
  void UserssSign(String id, String name, String email,String token,String role)
  {this.id=id; this.name=name; this.email=email;this.token=token;this.role=role;this.image="https://www.pngkey.com/png/full/284-2844044_fashion-toys-electrical-items-and-more-girl-with.png";}




  factory Userss.fromJson(Map<String, dynamic> json) => Userss(
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    token: json["token"] == null ? null : json["token"],
    lat: json["lat"] == null ? null : json["lat"],
    long: json["long"] == null ? null : json["long"],
    role: json["role"] == null ? null : json["role"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    timesTamp: json["timesTamp"] == null ? null : json["timesTamp"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "long": long == null ? null :long,
    "token": token == null ? null :token,
    "lat":  lat == null ? null :  lat,
    "role": role == null ? null : role,
    "phone":  phone == null ? null :  phone,
    "email": email == null ? null : email,
    "id": id == null ? null : id,
    "timesTamp": timesTamp == null ? null : timesTamp,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
  };


  @override
  String toString() {
    // var map = this.toMap();
    // map["auth"] = this.auth;
    // return map.toString();
  }

  bool profileCompleted() {
    return email != null  ;
    //return address != null && address != '' && phone != null && phone != '';
  }
}
