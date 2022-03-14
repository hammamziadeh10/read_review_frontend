import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 25),
              child: TextButton(
                child: const Text("Logout", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                onPressed: (){
                  deleteStorage(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteStorage(BuildContext context) {
    final storage = FlutterSecureStorage();
    storage.deleteAll();

    Navigator.of(context).pushReplacementNamed(
      "/",
    );
  }
}
