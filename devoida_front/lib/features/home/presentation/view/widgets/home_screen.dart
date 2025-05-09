import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:devoida_front/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF212121),
      //   leading: Image.asset('assets/images/Trello.png'),
      //   title: Text('Devoida', style: Styles.titleStyle,),
      // ),
      body: Column(
        children: [
          CustomAppBar(
            leadingImage: "assets/images/Trello.png",
            title: "Devoida",
            titleStyle: Styles.titleStyle.copyWith(color: kPrimaryBlue),
          ),
        ],
      ),
    );
  }
}
