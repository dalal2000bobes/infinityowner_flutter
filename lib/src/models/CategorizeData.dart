class CategorizeData {
  CategorizeData({
    this.nameAr,
    this.id,
    this.nameEn,
    this.image,
    this.hide
  });


  String nameAr;
  String id;
  String nameEn;
  String image;
  bool hide;

  factory CategorizeData.fromJson(Map<String, dynamic> json) => CategorizeData(

    nameAr: json["name_ar"] == null ? null : json["name_ar"],
    id: json["id"] == null ? null : json["id"],
    nameEn: json["name_en"] == null ? null : json["name_en"],
    image: json["image"] == null ? null : json["image"],
    hide: json["hide"] == null ? null : json["hide"],
  );

  Map<String, dynamic> toJson() => {
    "name_ar": nameAr == null ? null : nameAr,
    "id": id == null ? null : id,
    "name_en": nameEn == null ? null : nameEn,
    "image": image == null ? null : image,
    "hide": hide == null ? null : hide,
  };
}
