class DemandData {
  bool done;
  List<Product> product;
  String id;
  String idUser;
  String idWorker;
  String idMarket;
  List<String> idAdmins;
  String stateAr;
  String stateEn;
  bool remove;
  int timesTampdemand;
  int timesTampCreat;
  int priceTotal;
  double rating;
  bool iscoupon;

  DemandData(
      {this.done,
      this.product,
      this.id,
      this.idUser,
      this.idWorker,
      this.idMarket,
      this.idAdmins,
      this.stateAr,
      this.stateEn,
      this.remove,
      this.timesTampdemand,
      this.timesTampCreat,
      this.priceTotal,
      this.rating,
      this.iscoupon});

  DemandData.fromJson(Map<String, dynamic> json) {
    done = json["done"];
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
    id = json['id'];
    idUser = json['id_user'];
    idWorker = json['id_worker'];
    idMarket = json['id_market'];
    idAdmins = json['id_admins'].cast<String>();
    stateAr = json['state_ar'];
    stateEn = json['state_en'];
    remove = json['remove'];
    timesTampdemand = json['timesTampdemand'];
    timesTampCreat = json['timesTampCreat'];
    priceTotal = json['priceTotal'];
    rating = json['rating'].toDouble();
    iscoupon = json['iscoupon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_worker'] = this.idWorker;
    data['id_market'] = this.idMarket;
    data['id_admins'] = this.idAdmins;
    data['state_ar'] = this.stateAr;
    data['state_en'] = this.stateEn;
    data['remove'] = this.remove;
    data['timesTampdemand'] = this.timesTampdemand;
    data['timesTampCreat'] = this.timesTampCreat;
    data['priceTotal'] = this.priceTotal;
    data['rating'] = this.rating.toDouble();
    data['iscoupon'] = this.iscoupon;
    return data;
  }
}

class Product {
  String descriptionAr;
  String id;
  String note;
  int number;
  String image;
  String descriptionEn;
  String nameEn;
  int priceTotal;
  String nameAr;

  Product(
      {this.descriptionAr,
      this.id,
      this.note,
      this.number,
      this.image,
      this.descriptionEn,
      this.nameEn,
      this.priceTotal,
      this.nameAr});

  Product.fromJson(Map<String, dynamic> json) {
    descriptionAr = json['description_ar'];
    id = json['id'];
    note = json['note'];
    number = json['number'];
    image = json['image'];
    descriptionEn = json['description_en'];
    nameEn = json['name_en'];
    priceTotal = json['priceTotal'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description_ar'] = this.descriptionAr;
    data['id'] = this.id;
    data['note'] = this.note;
    data['number'] = this.number;
    data['image'] = this.image;
    data['description_en'] = this.descriptionEn;
    data['name_en'] = this.nameEn;
    data['priceTotal'] = this.priceTotal;
    data['name_ar'] = this.nameAr;
    return data;
  }
}
