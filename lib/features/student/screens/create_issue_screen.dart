import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_calls.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_utils.dart';
import 'package:youtube_tutorial_hostel_management/common/app_bar.dart';
import 'package:youtube_tutorial_hostel_management/common/custom_text_field.dart';
import 'package:youtube_tutorial_hostel_management/common/spacing.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/widgets/custom_button.dart';
import 'package:youtube_tutorial_hostel_management/theme/text_theme.dart';

class StudentCreateIssue extends StatefulWidget {
  const StudentCreateIssue({super.key});

  @override
  State<StudentCreateIssue> createState() => _StudentCreateIssueState();
}

class _StudentCreateIssueState extends State<StudentCreateIssue> {
  TextEditingController studentComment = TextEditingController();
  String? selectedIssue;

  ApiCall apiCall = ApiCall();
  List<String> issues = [
    "Bathroom",
    "Bedroom",
    "Water",
    "Furniture",
    "Kitchen"
  ];

  @override
  void dispose() {
    studentComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Create Issue"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpacer(15),
                Text(
                  "Room Number",
                  style: AppTextTheme.kLabelStyle,
                ),
                heightSpacer(15),
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
                      ApiUtils.roomNumber,
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
                heightSpacer(15),
                Text(
                  "Block Number",
                  style: AppTextTheme.kLabelStyle,
                ),
                heightSpacer(15),
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
                      ApiUtils.blockNumber,
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
                heightSpacer(15),
                Text(
                  "Your Email Id",
                  style: AppTextTheme.kLabelStyle,
                ),
                heightSpacer(15),
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
                      ApiUtils.email,
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
                heightSpacer(15),
                Text(
                  "Phone Number",
                  style: AppTextTheme.kLabelStyle,
                ),
                heightSpacer(15),
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
                      ApiUtils.phoneNumber,
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
                heightSpacer(15),
                Text(
                  "Issue you are facing?",
                  style: AppTextTheme.kLabelStyle,
                ),
                heightSpacer(15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  width: double.maxFinite,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xff2e8b57)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: selectedIssue,
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          selectedIssue = newValue;
                        },
                      );
                    },
                    items: issues.map((String issue) {
                      return DropdownMenuItem(value: issue, child: Text(issue));
                    }).toList(),
                  ),
                ),
                heightSpacer(15),
                Text(
                  "Comment",
                  style: AppTextTheme.kLabelStyle,
                ),
                heightSpacer(15),
                CustomTextField(
                  controller: studentComment,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Comment is required";
                    }
                    return null;
                  },
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffd1d8ff),
                      ),
                      borderRadius: BorderRadius.circular(14)),
                ),
                heightSpacer(30),
                CustomButton(
                    buttonText: "Submit",
                    onTap: () {
                      apiCall.createAnIssue(
                          context,
                          ApiUtils.roomNumber,
                          ApiUtils.blockNumber,
                          selectedIssue ?? "",
                          ApiUtils.email,
                          studentComment.text,
                          ApiUtils.phoneNumber);
                    }),
                heightSpacer(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
