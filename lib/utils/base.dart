import 'package:flutter/cupertino.dart';

abstract class BaseConnector {
  onError(String message);

  showLoading();
}

class BaseViewModel<CON extends BaseConnector> extends ChangeNotifier {
  CON? connector;
}

abstract class BaseView<VM extends BaseViewModel, S extends StatefulWidget>
    extends State<S> implements BaseConnector {
  late VM viewModel;

  VM init_my_view_model();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewModel = init_my_view_model();
  }
}
