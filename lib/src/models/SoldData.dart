class SoldData {
  bool hide;
  String id;
  String idMarket;
  String image;
  String imageIcon;
  String nameAr;
  String nameEn;
  String descriptionAr;
  String descriptionEn;
  String nameMarketAr;
  String nameMarketEn;
  int longDay;
  String timeSend;
  int timesTamp;
  int price;
  int lastPrice;

  SoldData(
      {this.hide,
        this.id,
        this.idMarket,
        this.image,
        this.imageIcon,
        this.nameAr,
        this.nameEn,
        this.descriptionAr,
        this.descriptionEn,
        this.nameMarketAr,
        this.nameMarketEn,
        this.longDay,
        this.timeSend,
        this.timesTamp,
        this.price,
        this.lastPrice,
      });

  SoldData.fromJson(Map<String, dynamic> json) {
    hide = json['hide'];
    id = json['id'];
    idMarket = json['id_market'];
    image = json['image'];
    imageIcon = json['image_icon'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    nameMarketAr = json['name_market_ar'];
    nameMarketEn = json['name_market_en'];
    longDay = json['longDay'];
    timeSend = json['timeSend'];
    timesTamp = json['timesTamp'];
    price = json['price'];
    lastPrice = json['lastPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hide'] = this.hide;
    data['id'] = this.id;
    data['id_market'] = this.idMarket;
    data['image'] = this.image;
    data['image_icon'] = this.imageIcon;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['name_market_ar'] = this.nameMarketAr;
    data['name_market_en'] = this.nameMarketEn;
    data['longDay'] = this.longDay;
    data['timeSend'] = this.timeSend;
    data['timesTamp'] = this.timesTamp;
    data['price'] = this.price;
    data['lastPrice'] = this.lastPrice;
    return data;
  }
}
