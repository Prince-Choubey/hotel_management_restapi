import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_calls.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_utils.dart';
import 'package:youtube_tutorial_hostel_management/common/app_bar.dart';
import 'package:youtube_tutorial_hostel_management/common/custom_text_field.dart';
import 'package:youtube_tutorial_hostel_management/common/spacing.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/widgets/custom_button.dart';

class ChangeRoomScreen extends StatefulWidget {
  const ChangeRoomScreen({super.key});

  @override
  State<ChangeRoomScreen> createState() => _ChangeRoomScreenState();
}

class _ChangeRoomScreenState extends State<ChangeRoomScreen> {
  String? selectedBlock;
  String? selectedRoom;

  ApiCall apiCall = ApiCall();

  TextEditingController reason = TextEditingController();

  List<String> blockOptions = ['A', 'B'];
  List<String> roomOptionA = ['101', '102', '103'];
  List<String> roomOptionB = ['201', '202', '203'];

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Change Room"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Block and Room Number",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            heightSpacer(10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: double.maxFinite,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xff2e8b57)),
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
                widthSpacer(30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: double.maxFinite,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xff2e8b57)),
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
              ],
            ),
            heightSpacer(20),
            Text(
              "Shift to Block and Room Number",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            heightSpacer(10),
            Row(
              children: [
                Container(
                  height: 50.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xff2e8b57),
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Row(
                    children: [
                      widthSpacer(20),
                      const Text("Block No."),
                      widthSpacer(8),
                      DropdownButton(
                        value: selectedBlock,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              selectedBlock = newValue;
                              selectedRoom = null;
                            },
                          );
                        },
                        items: blockOptions.map((String block) {
                          return DropdownMenuItem(
                            value: block,
                            child: Text(block),
                          );
                        }).toList(),
                      ),
                      widthSpacer(20),
                    ],
                  ),
                ),
                widthSpacer(20),
                Container(
                  height: 50.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xff2e8b57),
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Row(
                    children: [
                      widthSpacer(20),
                      const Text("Room No."),
                      widthSpacer(8),
                      DropdownButton<String>(
                        value: selectedRoom,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              selectedRoom = newValue;
                            },
                          );
                        },
                        items:
                            (selectedBlock == 'A' ? roomOptionA : roomOptionB)
                                .map((String room) {
                          return DropdownMenuItem<String>(
                              value: room, child: Text(room));
                        }).toList(),
                      ),
                      widthSpacer(20),
                    ],
                  ),
                ),
              ],
            ),
            heightSpacer(20),
            Text(
              "Reason for change",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            heightSpacer(10),
            CustomTextField(
              controller: reason,
              inputHint: 'Write your reason',
            ),
            heightSpacer(30),
            CustomButton(
                buttonText: "Submit",
                onTap: () {
                  apiCall.roomChangeRequest(
                      context, selectedRoom!, selectedBlock!, reason.text);
                })
          ],
        ),
      ),
    );
  }
}
