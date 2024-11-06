class NameModel {
  final String nameTitle;
  final String nameMeaning;
  final String nameDescription;
  final String nameCategory;

  NameModel({
    required this.nameTitle,
    required this.nameMeaning,
    required this.nameDescription,
    required this.nameCategory,
  });

  Map<String, dynamic> toJson() {
    return {
      'nameTitle': nameTitle,
      'nameMeaning': nameMeaning,
      'nameDescription': nameDescription,
      'nameCategory': nameCategory,
    };
  }


  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      nameTitle: json['nameTitle'],
      nameMeaning: json['nameMeaning'],
      nameDescription: json['nameDescription'],
      nameCategory: json['nameCategory'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NameModel && other.nameTitle == nameTitle;
  }

  @override
  int get hashCode => nameTitle.hashCode;
}
