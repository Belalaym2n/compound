import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'offlineNetworkScreen.dart';

class InternetWrapper extends StatelessWidget {
  final Widget child;

  const InternetWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
      ) {
        final bool connected = !connectivity.contains(ConnectivityResult.none);
        return connected ? this.child : const OfflineNetwork();
      },
      child: child,
    );
  }
}
