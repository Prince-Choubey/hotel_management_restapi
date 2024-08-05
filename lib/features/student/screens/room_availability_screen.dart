import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_provider.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_utils.dart';
import 'package:youtube_tutorial_hostel_management/common/app_bar.dart';
import 'package:youtube_tutorial_hostel_management/common/constants.dart';
import 'package:youtube_tutorial_hostel_management/common/spacing.dart';
import 'package:youtube_tutorial_hostel_management/features/admin/screens/room_change_request_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/student/screens/change_room_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/student/screens/room_availability_screen.dart';
import 'package:youtube_tutorial_hostel_management/models/room_availability_model.dart';
import 'package:youtube_tutorial_hostel_management/theme/colors.dart';

class RoomAvailability extends StatefulWidget {
  const RoomAvailability({super.key});

  @override
  State<RoomAvailability> createState() => _RoomAvailabilityState();
}

class _RoomAvailabilityState extends State<RoomAvailability> {
  RoomAvailabilityModel? roomAvailabilityModel;

  Future<void> fetchRoomAvailability() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);

      final roomAvailability =
          await apiProvider.getResponse(ApiUtils.roomAvailability);

      if (roomAvailability.statusCode == 200) {
        final Map<String, dynamic> room = json.decode(roomAvailability.body);
        roomAvailabilityModel = RoomAvailabilityModel.fromJson(room);
      }
    } catch (e) {
      print("error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Room Availability"),
      body: FutureBuilder(
        future: fetchRoomAvailability(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return roomAvailabilityModel == null
                ? const Center(child: Text("No Availability"))
                : ListView.builder(
                    padding: EdgeInsets.all(10.h),
                    itemCount: roomAvailabilityModel!.result.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: RoomCard(
                          room: roomAvailabilityModel!.result[index],
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

class RoomCard extends StatelessWidget {
  final Result room;

  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.r),
          topLeft: Radius.circular(30.r),
          bottomLeft: Radius.circular(30.r),
        ),
        border: Border.all(color: Color(0xff007b3b), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                AppConstants.bed,
                height: 70.h,
                width: 70.w,
              ),
              Text(
                "Room No. : ${room.roomNumber}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          widthSpacer(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Block: ${room.blockId.block}",
                style: TextStyle(fontSize: 16.sp),
              ),
              heightSpacer(5),
              Text(
                "Capacity: ${room.roomCapacity}",
                style: TextStyle(fontSize: 16.sp),
              ),
              heightSpacer(5),
              Text(
                "Current Capacity: ${room.roomCurrentCapacity}",
                style: TextStyle(fontSize: 16.sp),
              ),
              heightSpacer(5),
              Text(
                "Room Type: ${room.roomType?.roomType ?? ": Sharing"}",
                style: TextStyle(fontSize: 16.sp),
              ),
              heightSpacer(5),
              Row(
                children: [
                  Text(
                    "Status ",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  widthSpacer(10),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(
                        top: 3, left: 5, right: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff2ecc71),
                    ),
                    child: room.roomCurrentCapacity == 5
                        ? Text(
                            "Unavailable",
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const ChangeRoomScreen()));
                            },
                            child: Text(
                              "Available",
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
