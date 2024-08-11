import 'package:flutter/material.dart';

import 'onBoardModel.dart';





class OnboardingView extends StatelessWidget {
    OnboardingView({
    super.key,
    required this.data,
  });

  final OnBoardModel data;
  double screenWidth=0;
  double screenHight=0;

  @override
  Widget build(BuildContext context) {

    screenWidth= MediaQuery.of(context).size.width;
    screenHight= MediaQuery.of(context).size.height;
    return
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Padding(

          padding: const EdgeInsets.all(30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),

            child: Image(

              width: screenWidth*0.9,
              height: screenHight*0.32,
              image:  AssetImage( data.imageUrl,
              ),fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: screenHight*0.07,
        ),


        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                data.headline,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold,fontSize: 28),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  data.description,
                  style:
                  Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600,fontSize: 12),

                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
