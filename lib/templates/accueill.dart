import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../pages/page1.dart';
import '../services/database.dart';

class Accuel extends StatelessWidget {
  const Accuel({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    return user!.uid == null
        ? Container()
        : StreamProvider<List<AppUserData>>.value(
            initialData: const [],
            value: DatabaseService(uid: user.uid).users,
            child: StreamProvider<AppUserData?>.value(
              value: DatabaseService(uid: user.uid).user,
              initialData: AppUserData(uid: user.uid),
              child: const Page1(),
            ),
          );
  }
}
