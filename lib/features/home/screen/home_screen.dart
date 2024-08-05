import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_provider.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_utils.dart';
import 'package:youtube_tutorial_hostel_management/common/constants.dart';
import 'package:youtube_tutorial_hostel_management/common/spacing.dart';
import 'package:youtube_tutorial_hostel_management/features/admin/screens/create_staff_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/admin/screens/issue_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/admin/screens/room_change_request_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/admin/screens/staff_display_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/home/screen/widgets/category_card.dart';
import 'package:youtube_tutorial_hostel_management/features/student/screens/create_issue_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/student/screens/hostel_fee_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/student/screens/profile_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/student/screens/room_availability_screen.dart';
import 'package:youtube_tutorial_hostel_management/models/student_info_model.dart';
import 'package:youtube_tutorial_hostel_management/theme/text_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StudentInfoModel? studentInfoModel;

  Future<void> fetchStudentData(String emailId) async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);

      final studentInfo =
          await apiProvider.getResponse('${ApiUtils.studentInfo}$emailId');

      if (studentInfo.statusCode == 200) {
        final Map<String, dynamic> student = json.decode(studentInfo.body);
        studentInfoModel = StudentInfoModel.fromJson(student);
      }
    } catch (e) {
      print("error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudentData(ApiUtils.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff007b3b),
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "Dashboard",
          style: AppTextTheme.kLabelStyle
              .copyWith(fontSize: 22.sp, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset(AppConstants.profile)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              heightSpacer(20),
              Container(
                height: 140.h,
                width: double.maxFinite,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: Color(0xff007b3b),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(2),
                      )),
                  shadows: [
                    BoxShadow(
                        color: Color(0x332e8b57),
                        blurRadius: 8,
                        offset: Offset(2, 4),
                        spreadRadius: 0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              "${ApiUtils.firstName} ${ApiUtils.lastName}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff333333),
                                  fontSize: 24.sp),
                            ),
                          ),
                          heightSpacer(15),
                          Text(
                            "Room No. : ${ApiUtils.roomNumber}",
                            style: TextStyle(
                                color: const Color(0xff333333),
                                fontSize: 15.sp),
                          ),
                          Text(
                            "Block No. : ${ApiUtils.blockNumber}",
                            style: TextStyle(
                                color: const Color(0xff333333),
                                fontSize: 15.sp),
                          ),
                        ],
                      ),
                      widthSpacer(10),
                      Column(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const StudentCreateIssue(),
                                  ),
                                );
                              },
                              child:
                                  SvgPicture.asset(AppConstants.createIssue)),
                          Text(
                            "Create Issue",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              heightSpacer(30),
              Container(
                width: double.maxFinite,
                color: const Color(0xff262e8b57),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpacer(20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff333333),
                        ),
                      ),
                    ),
                    heightSpacer(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CategoryCard(
                          category: 'Room\nAvailability',
                          image: AppConstants.roomAvailability,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const RoomAvailability(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          category: 'All\nIssues',
                          image: AppConstants.allIssues,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const IssueScreen(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          category: 'Staff\nMembers',
                          image: AppConstants.staffMember,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const StaffDisplayScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    heightSpacer(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CategoryCard(
                          category: 'Create\nStaff',
                          image: AppConstants.createStaff,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const CreateStaff(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          category: 'Hostel\nFee',
                          image: AppConstants.hostelFee,
                          onTap: () {
                            final student = studentInfoModel!.result.first;
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => HostelFeeScreen(
                                  blockNumber: student.studentProfileData.block.toString(),
                                  roomNumber: student.studentProfileData.roomNumber.toString(),
                                  maintainanceCharge: student.roomChargesModel.maintenanceCharges.toString(),
                                  parkingCharge: student.roomChargesModel.parkingCharges.toString(),
                                  waterCharge: student.roomChargesModel.roomWaterCharges.toString(),
                                  roomCharge: student.roomChargesModel.roomAmount.toString(),
                                  totalCharge: student.roomChargesModel.totalAmount.toString(),
                                ),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          category: 'Change\nRequests',
                          image: AppConstants.roomChange,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const RoomChangeRequestScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    heightSpacer(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
