class DiningAtmosphereModel {
  final List<String> options;
  const DiningAtmosphereModel({required this.options});

  factory DiningAtmosphereModel.defaultOptions() => const DiningAtmosphereModel(
    options: [
      'Cozy & Intimate',
      'Lively & Energetic',
      'Romantic & Elegant',
      'Casual & Relaxed',
      'Family-Friendly',
      'Trendy & Modern',
    ],
  );
}
