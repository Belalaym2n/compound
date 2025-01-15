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
        description: 'Generate custom QR codes for visitors to quickly\n'
            'access essential details  and  streamline  entry\n'
            'processes.Enhance compound security by assigning\n'
            'temporary ,  trackable QR codes with  time-based\n'
            'validity.Simplify visitor management while ensuring\n'
            'controlled and efficient access.'),
    OnBoardModel(
      imageUrl: AppImages.orderImage,
      headline: 'Service Order ',
      description:
          'Request professional assistance for maintenance,\nrepair, or product purchases with ease. Provide\ndetailed service type and specifications to ensure\ntimely and accurate fulfillment of your requests.\nSimplify the process with clear and efficient\ncommunication.',
    ),
    OnBoardModel(
        imageUrl: AppImages.car_wash,
        headline: 'Check sales',
        description: 'We offer  high-quality car wash services to keep  your\n'
            'car clean easily and comfortably .Whether you need daily\n'
            'or monthly washing, we provide the most suitable options\n'
            'for your needs. Our monthly service offers great savings\n, '
            'while the daily wash ensures continuous cleanliness with \n'
            'fast, efficient service.')
  ];
}
