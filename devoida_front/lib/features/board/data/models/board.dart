class Board {
  int? id;
  String? name;
  int? workspaceId;
  int? createdBy;
  String? createdAt;

  Board({this.id, this.name, this.workspaceId, this.createdBy, this.createdAt});

  factory Board.fromJson(Map<String, dynamic> json) => Board(
    id: json['id'] as int?,
    name: json['name'] as String?,
    workspaceId: json['workspace_id'] as int?,
    createdBy: json['created_by'] as int?,
    createdAt: json['created_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'workspace_id': workspaceId,
    'created_by': createdBy,
    'created_at': createdAt,
  };
}
