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
import 'package:youtube_tutorial_hostel_management/models/issue_model.dart';
import 'package:youtube_tutorial_hostel_management/theme/text_theme.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  IssueModel? issueModel;

  Future<void> fetchStudentIssues() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);

      final issues = await apiProvider.getResponse(ApiUtils.studentIssues);

      if (issues.statusCode == 200) {
        final Map<String, dynamic> issue = json.decode(issues.body);
        issueModel = IssueModel.fromJson(issue);
      }
    } catch (e) {
      print("error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Student Issues"),
      body: FutureBuilder(
        future: fetchStudentIssues(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return issueModel == null
                ? const Center(child: Text("No Availability"))
                : ListView.builder(
                    padding: EdgeInsets.all(10.h),
                    itemCount: issueModel!.result.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: IssueCard(
                          issue: issueModel!.result[index],
                        ),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}

class IssueCard extends StatelessWidget {
  final Result issue;

  const IssueCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    ApiCall apiCall = ApiCall();
    return SizedBox(
      width: double.maxFinite,
      child: Flexible(
        child: Column(
          children: [
            heightSpacer(10),
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
                  Column(
                    children: [
                      heightSpacer(20),
                      Image.asset(
                        AppConstants.person,
                        height: 70.h,
                        width: 70.w,
                      ),
                      heightSpacer(10),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "${issue.studentDetails.firstName} ${issue.studentDetails.lastName}",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  widthSpacer(20),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpacer(10),
                        Text(
                          "Username: ${issue.studentDetails.userName} ",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        heightSpacer(10),
                        Text(
                          "Room Number: ${issue.roomDetails.roomNumber} ",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        heightSpacer(10),
                        Text(
                          "Email: ${issue.studentDetails.emailId} ",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        heightSpacer(10),
                        Text(
                          "Phone Number: ${issue.studentDetails.phoneNumber} ",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        heightSpacer(10),
                      ],
                    ),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Issue: ",
                                style: AppTextTheme.kLabelStyle.copyWith(
                                    fontSize: 16.sp, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "${issue.issue}",
                                style: AppTextTheme.kLabelStyle.copyWith(
                                    fontSize: 16.sp, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          heightSpacer(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Student Comment: ",
                                style: AppTextTheme.kLabelStyle.copyWith(
                                    fontSize: 16.sp, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "'${issue.studentComment}'",
                                style: AppTextTheme.kLabelStyle.copyWith(
                                    fontSize: 16.sp, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          heightSpacer(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  apiCall.closeAnIssue(
                                      context, "Resolved", issue.issueId);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  width: 140.w,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Resolve",
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
      ),
    );
  }
}
