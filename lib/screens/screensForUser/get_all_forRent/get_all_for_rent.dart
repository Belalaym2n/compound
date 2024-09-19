import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/screensForUser/get_all_forRent/rent_connector.dart';
import 'package:qr_code/screens/screensForUser/get_all_forRent/rent_details.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'for_rent_view_model.dart';

class GetAllAdv extends StatefulWidget {
  const GetAllAdv({super.key});

  @override
  State<GetAllAdv> createState() => _GetAllAdvState();
}

class _GetAllAdvState extends State<GetAllAdv> implements RentConnector {
  @override
  loading() {
    Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (192 / 220),
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2),
        itemBuilder: (context, index) {
          return Skeletonizer(
              child: products(
                  context: context,
                  tittle: "advs['tittle'].toString()",
                  description: "advs['description'].toString()",
                  imageUrl:
                      "https://th.bing.com/th/id/OIP.thxvwuvNfiwNZCL1m79IxgHaEb?w=306&h=183&c=7&r=0&o=5&dpr=1.4&pid=1.7"));
        },
      ),
    );
  }

  @override
  show_data() {
    // TODO: implement show_data
    throw UnimplementedError();
  }

  @override
  errorMessage(String error, BuildContext context) {
    // TODO: implement errorMessage
    return const Center(child: Text('something has wrong'));
  }

  ForRentViewModel viewModel = ForRentViewModel();

  @override
  void initState() {
    viewModel.connector = this;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => SafeArea(
        child: Scaffold(
            body: viewModel.getAllForRent(
                screenHeight: screenHeight, screenWidth: screenWidth)),
      ),
    );
  }

  Widget products(
      {required String tittle,
      required String imageUrl,
      required String description,
      required BuildContext context}) {
    return InkWell(
      onTap: () {
        print("not navigate");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RentDetails(
                  tittle: tittle, imageUrl: imageUrl, description: description),
            ));
      },
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: AppColors.primary,width: 2),
              borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight * 0.18,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.fill,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    tittle,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.03),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          description.length < 10
                              ? description
                              : description.substring(0, 10),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.03),
                        ),
                      ),
                    ),
                    const Icon(Icons.ads_click)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double screenWidth = 0;
double screenHeight = 0;
