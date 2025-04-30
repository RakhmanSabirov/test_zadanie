class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CharacterModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  // Преобразование в Map для хранения в базе данных
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'image': image,
    };
  }

  // Создание объекта из Map
  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      species: map['species'],
      gender: map['gender'],
      image: map['image'],
    );
  }

  // Создание объекта из JSON
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'],
    );
  }

  // Преобразование в JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'gender': gender,
    'image': image,
  };
  @override
  String toString() {
    return 'CharacterModel(name: $name, status: $status, species: $species, image: $image)';
  }
}
