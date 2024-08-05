import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_calls.dart';
import 'package:youtube_tutorial_hostel_management/common/constants.dart';
import 'package:youtube_tutorial_hostel_management/common/spacing.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/widgets/custom_button.dart';
import 'package:youtube_tutorial_hostel_management/features/home/screen/home_screen.dart';
import 'package:youtube_tutorial_hostel_management/theme/colors.dart';
import 'package:youtube_tutorial_hostel_management/theme/text_theme.dart';

import '../../../common/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  ApiCall apiCall = ApiCall();

  String? selectedBlock;
  String? selectedRoom;

  List<String> blockOptions = ['A', 'B'];
  List<String> roomOptionA = ['101', '102', '103'];
  List<String> roomOptionB = ['201', '202', '203'];

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpacer(40),
                Center(
                  child: Image.asset(
                    AppConstants.logo,
                    height: 150.h,
                    width: 150.w,
                  ),
                ),
                heightSpacer(30),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Register your account",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                heightSpacer(25),
                Text(
                  "UserName",
                  style: AppTextTheme.kLabelStyle,
                ),
                CustomTextField(
                  controller: username,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your username",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Text(
                  "First Name",
                  style: AppTextTheme.kLabelStyle,
                ),
                CustomTextField(
                  controller: firstName,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your first name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Text(
                  "Last Name",
                  style: AppTextTheme.kLabelStyle,
                ),
                CustomTextField(
                  controller: lastName,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your last name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Last name is required";
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Text(
                  "Email",
                  style: AppTextTheme.kLabelStyle,
                ),
                CustomTextField(
                  controller: email,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your Email",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    }else if(!emailRegex.hasMatch(value)){
                      return "Invalid email address";
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Text(
                  "Password",
                  style: AppTextTheme.kLabelStyle,
                ),
                CustomTextField(
                  controller: password,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Text(
                  "Phone Number",
                  style: AppTextTheme.kLabelStyle,
                ),
                CustomTextField(
                  controller: phoneNumber,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your Phone Number",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone Number is required";
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
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
                            items: (selectedBlock == 'A'
                                    ? roomOptionA
                                    : roomOptionB)
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
                heightSpacer(25),
                CustomButton(
                  buttonText: "Register",
                  onTap: () {
                    print(selectedBlock);
                    print(selectedRoom);
                    if (_formKey.currentState!.validate()) {
                      apiCall.registerStudent(
                          context,
                          email.text,
                          username.text,
                          firstName.text,
                          lastName.text,
                          phoneNumber.text,
                          selectedBlock ?? "",
                          selectedRoom ?? "",
                          password.text);
                    }
                  },
                ),
                heightSpacer(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
  final emailRegex = RegExp(r'^[\w-]+(.[\w-]+)@[\w-]+(.[\w-]+)(.[a-z]{2,})$');
}
