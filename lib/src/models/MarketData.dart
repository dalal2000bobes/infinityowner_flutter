class MarketData {
  String descriptionAr;
  String descriptionEn;
  bool hide;
  String id;
  String idSection;
  String image;
  String imageIcon;
  double lat; //location DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
  double long; //location DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
  String nameEn;
  List<String> owners;
  String nameAr;
  int timesTampClose; //time DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
  int timesTampOpen; //Time DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
  double rating;
  bool active;

  MarketData(
      {this.descriptionAr,
      this.descriptionEn,
      this.hide,
      this.id,
      this.idSection,
      this.image,
      this.imageIcon,
      this.lat,
      this.long,
      this.owners,
      this.nameEn,
      this.nameAr,
      this.timesTampClose,
      this.timesTampOpen,
      this.rating});

  MarketData.fromJson(Map<String, dynamic> json) {
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    hide = json['hide'];
    id = json['id'];
    idSection = json['id_section'];
    image = json['image'];
    imageIcon = json['image_icon'];
    lat = json['lat'];
    long = json['long'];
    owners = json['owners'].cast<String>();
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    timesTampClose = json['timesTampClose'];
    timesTampOpen = json['timesTampOpen'];
    rating =json['rating'].toDouble();
    active =json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['hide'] = this.hide;
    data['id'] = this.id;
    data['id_section'] = this.idSection;
    data['image'] = this.image;
    data['image_icon'] = this.imageIcon;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['owners'] = this.owners;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['timesTampClose'] = this.timesTampClose;
    data['timesTampOpen'] = this.timesTampOpen;
    data['rating'] = this.rating.toDouble();
    data['active'] = this.active;
    return data;
  }
}
