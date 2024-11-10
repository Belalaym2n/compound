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
        imageUrl: AppImages.orderImage,
        headline: 'Service Order ',
        description:
            ' Request for professional assistance for maintenance, repair, or product purchase. Details include service type and specifications for timely fulfillment.'),
    OnBoardModel(
        imageUrl: AppImages.qrImage3,
        headline: 'Check sales',
        description:
            'Explore apartments for sale in our exclusive compound: Discover modern, stylish units within a secure, well-equipped community'),
  ];
}
