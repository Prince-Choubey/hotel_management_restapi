import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_provider.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_utils.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/screens/login_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/home/screen/home_screen.dart';
import 'package:youtube_tutorial_hostel_management/models/user_response.dart';

class ApiCall {
  Future<void> handleLogin(
      BuildContext context, String email, String password) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    final Map<String, dynamic> requestData = {
      "emailId": email,
      "password": password
    };

    final response = await apiProvider.postResponse(
      ApiUtils.login,
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestData,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == "FAILED") {
        ApiUtils.showErrorSnackBar(context, responseBody['error']);
      }
      final UserResponse userResponse = UserResponse.fromJson(responseBody);
      print("user email: ${userResponse.result[0].emailId}");

      ApiUtils.email = userResponse.result[0].emailId!;
      ApiUtils.phoneNumber = userResponse.result[0].phoneNumber.toString();
      ApiUtils.roomNumber = userResponse.result[0].roomNumber.toString();
      ApiUtils.blockNumber = userResponse.result[0].block.toString();
      ApiUtils.username = userResponse.result[0].userName;
      ApiUtils.firstName = userResponse.result[0].firstName!;
      ApiUtils.lastName = userResponse.result[0].lastName!;
      ApiUtils.roleId = userResponse.result[0].roleId?.roleId;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      ApiUtils.showSuccessSnackBar(context, "Login Successfully");
    } else {
      final Map<String, dynamic> errorResponse = json.decode(response.body);
      ApiUtils.showErrorSnackBar(context, errorResponse['msg']);
    }
  }

  Future<String?> registerStudent(
      BuildContext context,
      String email,
      String userName,
      String firstName,
      String lastName,
      String phoneNumber,
      String block,
      String roomNumber,
      String password) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    final Map<String, dynamic> requestData = {
      "userName": userName,
      "emailId": email,
      "password": password,
      "roleId": 2,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "roomNumber": roomNumber,
      "block": block,
    };

    final response = await apiProvider.postResponse(
      ApiUtils.register,
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestData,
    );
    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == "Student created successfully") {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
      if (responseBody['status'] == "202") {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody['status'] == "Student Already Exists") {
          ApiUtils.showErrorSnackBar(context, responseBody['status']);
        }
      }
    } else {
      final Map<String, dynamic> errorResponse = json.decode(response.body);
      ApiUtils.showErrorSnackBar(context, errorResponse['msg']);
    }
    return null;
  }

  /// Create Staff
  Future<String?> createStaff(
    String username,
    String firstName,
    String lastName,
    String jobRole,
    String email,
    String password,
    String phoneNumber,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "userName": username,
      "firstName": firstName,
      "lastName": lastName,
      "jobRole": jobRole,
      "emailId": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "roleId": 3,
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postResponse(
      ApiUtils.createStaff,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(response.statusCode);
    print(requestData);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        // ignore: use_build_context_synchronously
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => const HomeScreen()));
        // return responseBody['msg'];
      }
    }
    return null;
  }

  Future<String?> createAnIssue(
    BuildContext context,
    String roomNumber,
    String blockNumber,
    String issue,
    String email,
    String comment,
    String phoneNumber,
  ) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    final Map<String, dynamic> requestData = {
      "roomNumber": roomNumber,
      "block": blockNumber,
      "issue": issue,
      "studentComment": comment,
      "studentEmailId": email
    };

    final response = await apiProvider.postResponse(
      ApiUtils.createIssue,
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestData,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
    return null;
  }

  Future<String?> roomChangeRequest(
    BuildContext context,
    String changeRoomNumber,
    String changeBlockNumber,
    String reason,
  ) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    final Map<String, dynamic> requestData = {
      "currentRoomNumber": ApiUtils.roomNumber,
      "toChangeRoomNumber": changeRoomNumber,
      "currentBlock": ApiUtils.blockNumber,
      "toChangeBlock": changeBlockNumber,
      "studentEmailId": ApiUtils.email,
      "changeReason": reason,
    };

    final response = await apiProvider.postResponse(
      ApiUtils.roomChangeRequest,
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestData,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
    return null;
  }

  void deleteStaff(BuildContext context, String emailId) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    final response = await apiProvider.deleteResponse(
      '${ApiUtils.deleteStaff}$emailId',
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }

  Future<String?> approveOrReject(BuildContext context, String adminComment,
      String action, int requestId) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    final Map<String, dynamic> requestData = {
      "roomChangeRequestId": requestId,
      "approveOrReject": action,
      "adminComment": adminComment
    };
    final response = await apiProvider.postResponse(
      ApiUtils.acceptOrReject,
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestData,
    );

    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
    return null;
  }

  Future<String?> closeAnIssue(BuildContext context, String staffComment,
       int issueId) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    final Map<String, dynamic> requestData = {
      "issueId":issueId,
      "staffComment":staffComment
    };
    final response = await apiProvider.postResponse(
      ApiUtils.closeAnIssue,
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestData,
    );

    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }

  /// Create Staff
}
