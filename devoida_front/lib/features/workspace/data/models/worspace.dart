class Worspace {
  int? id;
  String? name;
  String? description;
  int? createdBy;

  Worspace({this.id, this.name, this.description, this.createdBy});

  factory Worspace.fromJson(Map<String, dynamic> json) => Worspace(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    createdBy: json['created_by'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'created_by': createdBy,
  };
}
