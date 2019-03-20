import 'package:flutter/material.dart';

import 'package:misterija_mk/models/users.dart';

class DrawerProfileHeader extends StatelessWidget {
  DrawerProfileHeader({@required this.currentProfile});

  final CurrentProfile currentProfile;

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        currentProfile.user.firstName.isEmpty ? currentProfile.user.lastName.isEmpty ? currentProfile.user.username : currentProfile.user.lastName : currentProfile.user.firstName + ' ' + currentProfile.user.lastName,
      ),
      accountEmail: Text(
        currentProfile.user.email.isEmpty ? 'Корисникот нема внесено е-пошта' : currentProfile.user.email,
      ),
      currentAccountPicture: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                currentProfile.avatar,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(50)
            )
        ),
      ),
    );
  }
}