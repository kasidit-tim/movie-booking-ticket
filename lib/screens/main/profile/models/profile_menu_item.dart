class ProfileMenuItem {
  final String title;
  final String iconAsset;
  final bool hasSwitch;

  const ProfileMenuItem({
    required this.title,
    required this.iconAsset,
    this.hasSwitch = false,
  });
}
