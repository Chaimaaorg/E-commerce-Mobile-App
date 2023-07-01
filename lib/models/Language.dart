class Language {
  final String name;
  final String code;

  Language({required this.name, required this.code});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Language && other.name == name && other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}
