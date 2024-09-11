import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/for_sale/get_all_forRent/rent_details.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'detAllViewModel.dart';

class GetAllAdv extends StatelessWidget {
  const GetAllAdv({super.key});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    GetAllAdvsViewModel viewModel = GetAllAdvsViewModel();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              FutureBuilder(
                  future: viewModel.getMessage(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: GridView.builder(
                          itemCount: 10,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (192 / 220),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2),
                          itemBuilder: (context, index) {
                            return Skeletonizer(
                                child: products(
                                    context: context,
                                    tittle: "advs['tittle'].toString()",
                                    description:
                                        "advs['description'].toString()",
                                    imageUrl:
                                        "https://th.bing.com/th/id/OIP.thxvwuvNfiwNZCL1m79IxgHaEb?w=306&h=183&c=7&r=0&o=5&dpr=1.4&pid=1.7"));
                          },
                        ),
                      ); // Loading indicator
                    } else if (snapshot.hasError) {
                      // print(snapshot.error.toString());
                      return Center(
                          child: Text(
                              'Error: ${snapshot.error}')); // Error handling
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No Advs found')); // Empty list handling
                    } else {
                      final Advs = snapshot.data!.docs;
                      return Expanded(
                        child: GridView.builder(
                          itemCount: Advs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (192 / 220),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2),
                          itemBuilder: (context, index) {
                            final advs = Advs[index];

                            return products(
                                context: context,
                                tittle: advs['tittle'].toString(),
                                description: advs['description'].toString(),
                                imageUrl: advs['image']);
                          },
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  products(
          {required String tittle,
          required String imageUrl,
          required String description,
          required BuildContext context}) =>
      InkWell(
        onTap: () {
          print("not navigate");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RentDetails(
                    tittle: tittle,
                    imageUrl: imageUrl,
                    description: description),
              ));
        },
        child: Container(
            margin: const EdgeInsets.only(left: 12, top: 16, right: 12),
            //height: screenHeight*0.2,

            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                    // border: Border.all(color: AppColors.primary,width: 2),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenWidth * 0.45,
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
            )),
      );
}

double screenWidth = 0;
double screenHeight = 0;
