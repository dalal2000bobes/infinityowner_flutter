class SectionData {
  SectionData({
    this.image,
    this.hide,
    this.nameAr,
    this.id,
    this.timesTamp,
    this.nameEn,
  });

  String image;
  bool hide;
  String nameAr;
  String id;
  int timesTamp;
  String nameEn;

  factory SectionData.fromJson(Map<String, dynamic> json) => SectionData(
    image: json["image"] == null ? null : json["image"],
    hide: json["hide"] == null ? null : json["hide"],
    nameAr: json["name_ar"] == null ? null : json["name_ar"],
    id: json["id"] == null ? null : json["id"],
    timesTamp: json["timesTamp"] == null ? null : json["timesTamp"],
    nameEn: json["name_en"] == null ? null : json["name_en"],
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? null : image,
    "hide": hide == null ? null : hide,
    "name_ar": nameAr == null ? null : nameAr,
    "id": id == null ? null : id,
    "timesTamp": timesTamp == null ? null : timesTamp,
    "name_en": nameEn == null ? null : nameEn,
  };
}
