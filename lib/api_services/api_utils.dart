import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApiUtils {
  static const String baseUrl = "https://unt-house-management.onrender.com/unt";
  static const String login = "/student/login";
  static const String register = "/student/saveStudent";
  static const String createStaff = '/admin/create/staff';
  static const String createIssue = '/maintenance/createIssue';
  static const String roomAvailability = '/room/getRooms/AVAILABLE';
  static const String studentIssues = '/maintenance/fetch/issue/OPEN';
  static const String allStaffs = '/admin/fetch/allStaff';
  static const String studentInfo = '/student/getStudentDetails?studentEmailId=';
  static const String studentRoomChangeRequest = '/room/fetch/roomChange/requests';
  static const String roomChangeRequest = '/room/change/request';
  static const String deleteStaff = '/admin/delete/staff/';
  static const String acceptOrReject = '/admin/approveOrReject';
  static const String closeAnIssue = '/maintenance/close/issue';


  // User Info
  static String email="";
  static String roomNumber="";
  static String blockNumber="";
  static String username="";
  static String firstName="";
  static String lastName="";
  static String phoneNumber="";
  static int? roleId;

  /// Snack bar
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
    static void showSuccessSnackBar(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
  }
}
