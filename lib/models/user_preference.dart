class UserPreference {
  final List<String> favoriteCategories;
  final bool darkMode;
  final String language;

  UserPreference({
    required this.favoriteCategories,
    required this.darkMode,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
    "favoriteCategories": favoriteCategories,
    "darkMode": darkMode,
    "language": language,
  };

  factory UserPreference.fromJson(Map<String, dynamic> json) {
    return UserPreference(
      favoriteCategories: List<String>.from(json["favoriteCategories"] ?? []),
      darkMode: json["darkMode"] ?? false,
      language: json["language"] ?? "fr",
    );
  }
}

