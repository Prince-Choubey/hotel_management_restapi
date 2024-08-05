import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_calls.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_provider.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_utils.dart';
import 'package:youtube_tutorial_hostel_management/common/app_bar.dart';
import 'package:youtube_tutorial_hostel_management/common/constants.dart';
import 'package:youtube_tutorial_hostel_management/common/spacing.dart';
import 'package:youtube_tutorial_hostel_management/models/room_change_model.dart';
import 'package:youtube_tutorial_hostel_management/theme/text_theme.dart';

class RoomChangeRequestScreen extends StatefulWidget {
  const RoomChangeRequestScreen({super.key});

  @override
  State<RoomChangeRequestScreen> createState() =>
      _RoomChangeRequestScreenState();
}

class _RoomChangeRequestScreenState extends State<RoomChangeRequestScreen> {
  RoomChangeModel? roomChangeModel;

  Future<void> fetchRoomChangeRequests() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);

      final requests =
          await apiProvider.getResponse(ApiUtils.studentRoomChangeRequest);

      if (requests.statusCode == 200) {
        final Map<String, dynamic> request = json.decode(requests.body);
        roomChangeModel = RoomChangeModel.fromJson(request);
      }
    } catch (e) {
      print("error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Room Change Requests"),
      body: ApiUtils.roleId != 1
          ? const Center(
              child: Text("You don't have permission to view this page"))
          : FutureBuilder(
              future: fetchRoomChangeRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  return roomChangeModel == null
                      ? const Center(child: Text("No Availability"))
                      : ListView.builder(
                          itemCount: roomChangeModel!.result.length,
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            return RequestCard(
                              requests: roomChangeModel!.result[index],
                            );
                          },
                        );
                }
              },
            ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final Result requests;

  const RequestCard({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    ApiCall apiCall = ApiCall();
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          heightSpacer(20),
          Container(
            decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0.00, -1.00),
                  end: const Alignment(0, 1),
                  colors: [
                    const Color(0xff2e8b57).withOpacity(0.5),
                    const Color(0x002e8857)
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ))),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      heightSpacer(20),
                      Image.asset(
                        AppConstants.person,
                        height: 70.h,
                        width: 70.w,
                      ),
                      heightSpacer(10),
                      Text(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        "${requests.studentDetails.firstName} ${requests.studentDetails.lastName}",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                widthSpacer(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpacer(10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "Username: ${requests.studentDetails.userName} ",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    heightSpacer(10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "Current Block: ${requests.currentBlock}",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    heightSpacer(10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "Current Room: ${requests.currentRoomNumber}",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    heightSpacer(10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "Email: ${requests.studentDetails.emailId}",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    heightSpacer(10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "Phone Number: ${requests.studentDetails.phoneNumber} ",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    heightSpacer(10),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 150.h,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Asked For: ",
                              style: AppTextTheme.kLabelStyle.copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Block : ${requests.toChangeBlock} ",
                                  style: AppTextTheme.kLabelStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.pink,
                                      fontWeight: FontWeight.w400),
                                ),
                                widthSpacer(20),
                                Text(
                                  "Room No : ${requests.toChangeRoomNumber}",
                                  style: AppTextTheme.kLabelStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.pink,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        heightSpacer(12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reason: ",
                              style: AppTextTheme.kLabelStyle.copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "'${requests.changeReason}'",
                              style: AppTextTheme.kLabelStyle.copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        heightSpacer(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                apiCall.approveOrReject(context, "REJECTED",
                                    "REJECTED", requests.roomChangeRequestId);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                width: 140.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xffed6a77),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Reject",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                apiCall.approveOrReject(context, "APPROVED",
                                    "APPROVED", requests.roomChangeRequestId);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                width: 140.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xff2ecc71),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Approve",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
