class ProductData {
  ProductData({
    this.description_ar,
    this.description_en,
    this.id_categorize,
    this.id,
    this.image,
    this.hide,
    this.nameAr,
    this.price,
    this.nameEn,
    this.note,
  });

  String image;
  bool hide;
  String nameAr;
  String note;
  int price;
  String nameEn;
  String description_ar;
  String description_en;
  String id_categorize;
  String id;

  factory ProductData.fromJson(Map<String, dynamic> json) =>ProductData(
    image: json["image"] == null ? null : json["image"],
    hide: json["hide"] == null ? null : json["hide"],
    nameAr: json["name_ar"] == null ? null : json["name_ar"],
    nameEn: json["name_en"] == null ? null : json["name_en"],
    id: json["id"] == null ? null : json["id"],
    id_categorize: json["id_categorize"] == null ? null : json["id_categorize"],
    note: json["note"] == null ? null : json["note"],
    price: json["price"] == null ? null : json["price"],
    description_en: json["description_en"] == null ? null : json["description_en"],
    description_ar: json["description_ar"] == null ? null : json["description_ar"],
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? null : image,
    "hide": hide == null ? null : hide,
    "name_ar": nameAr == null ? null : nameAr,
    "name_en": nameEn == null ? null : nameEn,
    "id": id == null ? null : id,
    "id_categorize": id_categorize == null ? null : id_categorize,
    "note":  note == null ? null :  note,
    "price":   price == null ? null :   price,
    "description_en":   description_en == null ? null :  description_en,
    "description_ar":   description_ar == null ? null :  description_ar,

  };
}
