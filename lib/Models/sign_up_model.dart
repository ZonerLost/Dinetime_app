class SignUpModel {
  /// Top hero artwork (PNG/SVG)
  final String heroAsset;

  /// Social icons (PNG/SVG). Use whatever you have; these are just paths.
  final String googleIcon;
  final String appleIcon;
  final String facebookIcon;

  /// Optional “eye” icon for password visibility (PNG/SVG)
  final String eyeOnIcon;


  const SignUpModel({
    required this.heroAsset,
    required this.googleIcon,
    required this.appleIcon,
    required this.facebookIcon,
    required this.eyeOnIcon,

  });
}
