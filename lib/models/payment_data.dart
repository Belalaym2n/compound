class PaymentData {
  static String _apiKey = "";
  static String _integrationCardId = "";
  static String _iframeId = "";

  static void initialize({
    required String apiKey,
    required String iframeId,
    required String integrationCardId,
  }) {
    PaymentData._apiKey = apiKey;
    PaymentData._iframeId = iframeId;
    PaymentData._integrationCardId = integrationCardId;
  }

  String get apiKey => PaymentData._apiKey;

  String get integrationCardId => PaymentData._integrationCardId;

  String get iframeId => PaymentData._iframeId;
}
