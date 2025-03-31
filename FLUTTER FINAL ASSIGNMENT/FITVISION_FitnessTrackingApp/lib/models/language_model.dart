class Language {
  final String code;
  final String name;

  Language(this.code, this.name);

  static List<Language> languageList() {
    return <Language>[
      Language('en', 'English'),
      Language('es', 'Español'),
      Language('fr', 'Français'),
      Language('hi', 'हिन्दी'),
      Language('ta', 'தமிழ்'),
      Language('te', 'తెలుగు'),
    ];
  }
}
