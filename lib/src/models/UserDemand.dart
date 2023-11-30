class UserDemand {
  String email;
  String id;
  String image;
  int lat;
  int long;
  String name;
  int phone;
  String role;
  int timesTamp;
  String token;

  UserDemand(
      {this.email,
        this.id,
        this.image,
        this.lat,
        this.long,
        this.name,
        this.phone,
        this.role,
        this.timesTamp,
        this.token});

  UserDemand.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    image = json['image'];
    lat = json['lat'];
    long = json['longe'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    timesTamp = json['timesTamp'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['longe'] = this.long;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['timesTamp'] = this.timesTamp;
    data['token'] = this.token;
    return data;
  }
}
