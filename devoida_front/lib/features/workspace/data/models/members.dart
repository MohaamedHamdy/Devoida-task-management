class Members {
  int? id;
  String? username;
  String? email;
  String? profilePicture;
  String? createdAt;

  Members({
    this.id,
    this.username,
    this.email,
    this.profilePicture,
    this.createdAt,
  });

  factory Members.fromJson(Map<String, dynamic> json) => Members(
    id: json['id'] as int?,
    username: json['username'] as String?,
    email: json['email'] as String?,
    profilePicture: json['profile_picture'] as String?,
    createdAt: json['created_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'profile_picture': profilePicture,
    'created_at': createdAt,
  };
}
