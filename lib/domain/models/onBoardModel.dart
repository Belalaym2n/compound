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
            'access essential details and streamline entry\n'
            'processes. Enhance compound security by assigning\n'
            'temporary, trackable QR codes with time-based\n'
            'validity. Simplify visitor management while ensuring\n'
            'controlled and efficient access.'),
    OnBoardModel(
        imageUrl: AppImages.orderImage,
        headline: 'Service Order',
        description: 'Request professional assistance for maintenance,\n'
            'repair, or product purchases with ease. Provide\n'
            'detailed service type and specifications to ensure\n'
            'timely and accurate fulfillment of your requests.\n'
            'Simplify the process with clear and efficient\n'
            'communication.'),
    OnBoardModel(
        imageUrl: AppImages.car_wash,
        headline: 'Car Wash',
        description: 'Book your car wash easily with just a few taps.\n'
            'Choose from quick exterior cleaning or a  thorough\n'
            'interior detailing. Enjoy the convenience of scheduling\n'
            'your car wash anytime, anywhere, ensuring your car \n'
            'always looks its best. Simplify your experience \n'
            '  with our efficient booking system.')
  ];
}
