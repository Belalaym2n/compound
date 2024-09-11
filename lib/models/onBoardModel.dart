import '../../utils/app_images.dart';

class OnBoardModel {
  String imageUrl;
  String headline;
  String description;

  OnBoardModel(
      {required this.imageUrl,
      required this.headline,
      required this.description});

  static List<OnBoardModel> items = [
    OnBoardModel(
        imageUrl: AppImages.qrImage,
        headline: 'Generate QR Code',
        description:
            'Create custom QR codes for your visitors to access information quickly,to improve security in compound'),
    OnBoardModel(
        imageUrl: AppImages.qrImage2,
        headline: 'Chat With Admin',
        description:
            ' Connect directly with our admin team for quick assistance, support, or answers to your questions. We re here to help!'),
    OnBoardModel(
        imageUrl: AppImages.qrImage3,
        headline: 'Check sales in compound',
        description:
            'Explore apartments for sale in our exclusive compound: Discover modern, stylish units within a secure, well-equipped community'),
  ];
}
