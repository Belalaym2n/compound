import 'package:flutter/cupertino.dart';
import 'package:qr_code/ui/core/profile/widgets/profile_screen_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ProfileScreenItem();
  }
}
