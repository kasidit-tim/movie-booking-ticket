import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/screens/main/profile/models/profile_menu_item.dart';

final List<ProfileMenuItem> profileMenuItems = [
  ProfileMenuItem(
    iconAsset: Assets.images.profileMenu.ticket.path,
    title: "My ticket",
  ),
  ProfileMenuItem(
    iconAsset: Assets.images.profileMenu.shoppingCart.path,
    title: "Payment history",
  ),
  ProfileMenuItem(
    iconAsset: Assets.images.profileMenu.translate.path,
    title: "Change language",
  ),
  ProfileMenuItem(
    iconAsset: Assets.images.profileMenu.lock.path,
    title: "Change password",
  ),
  ProfileMenuItem(
    iconAsset: Assets.images.profileMenu.faceId.path,
    title: "Face ID / Touch ID",
    hasSwitch: true,
  ),
];
