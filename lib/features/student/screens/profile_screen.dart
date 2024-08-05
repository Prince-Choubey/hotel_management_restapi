import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_utils.dart';
import 'package:youtube_tutorial_hostel_management/common/constants.dart';
import 'package:youtube_tutorial_hostel_management/common/custom_text_field.dart';
import 'package:youtube_tutorial_hostel_management/common/spacing.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/screens/login_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/widgets/custom_button.dart';
import 'package:youtube_tutorial_hostel_management/theme/colors.dart';
import 'package:youtube_tutorial_hostel_management/theme/text_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kGreenColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        title: Text("Profile",
            style: AppTextTheme.kLabelStyle.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => LoginScreen()));
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child:
          ApiUtils.roleId==1? Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppConstants.profile,
                  height: 160.h,
                  width: 10.w,
                ),
              ),
              heightSpacer(10),
              Text(
                "You are an Admin",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
            ],
          )
         :

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppConstants.profile,
                height: 160.h,
                width: 10.w,
              ),
              heightSpacer(10),
              Text(
                "${ApiUtils.firstName} ${ApiUtils.lastName}",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              heightSpacer(30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: double.maxFinite,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                          const BorderSide(width: 1, color: Color(0xff2e8b57)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Room No - ${ApiUtils.roomNumber}",
                          style: TextStyle(
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  widthSpacer(30),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: double.maxFinite,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                          const BorderSide(width: 1, color: Color(0xff2e8b57)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Block No - ${ApiUtils.blockNumber}",
                          style: TextStyle(
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
        
                ],
              ),
              heightSpacer(20),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.maxFinite,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side:
                    const BorderSide(width: 1, color: Color(0xff2e8b57)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${ApiUtils.email}",
                    style: TextStyle(
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ),
              heightSpacer(20),
              CustomTextField(
                controller: name,
                inputHint: ApiUtils.username,
                prefixIcon: Icon(Icons.person_2_outlined),
              ),
              heightSpacer(20),
              CustomTextField(
                controller: phoneNumber,
                inputHint: ApiUtils.phoneNumber,
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              heightSpacer(20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: firstName,
                      inputHint: ApiUtils.firstName,
        
                    ),
                  ),
                  widthSpacer(20),
                  Expanded(
                    child: CustomTextField(
                      controller: lastName,
                      inputHint: ApiUtils.lastName,
        
                    ),
                  )
                ],
              ),
              heightSpacer(30),
              CustomButton(buttonText: "Save", onTap: (){
                
              })
            ],
          ),
        ),
      ),
    );
  }
}
