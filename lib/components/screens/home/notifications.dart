import 'package:flutter/material.dart';

import '../../../services.dart';

class NotificationsComponet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Data.user.phone);
    return Center(child: Text("Notifiactions"));
  }
}
