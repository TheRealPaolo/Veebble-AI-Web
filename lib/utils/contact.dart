// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:veebble_web/utils/responsive.dart';

class EmailPage extends StatelessWidget {
  EmailPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          leading: IconButton(
              onPressed: () {
                //
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            "Back",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        body: ResponsiveWidget(
          mobile: Center(
            child: Container(
              height: 50.h,
              width: 80.w,
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Contact Us',
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 10.sp)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white)),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Required*';
                        } else if (!EmailValidator.validate(email)) {
                          return 'Please enter a valid Email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: 'Message',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 10.sp)),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                      width: 30.w,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xff151534),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await sendEmail(
                                nameController.value.text,
                                emailController.value.text,
                                messageController.value.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              response == 200
                                  ? const SnackBar(
                                      content: Text('Message Sent!'),
                                      backgroundColor: Colors.deepPurple)
                                  : const SnackBar(
                                      content: Text('Failed to send message!'),
                                      backgroundColor: Colors.red),
                            );
                            nameController.clear();
                            emailController.clear();
                            messageController.clear();
                          }
                        },
                        child: Text('Send', style: TextStyle(fontSize: 13.sp)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
/////////////////////////////////////DESKTOP////////////////////////////////////////////////////////////////////////////////////////
          desktop: Center(
            child: Container(
              height: 450,
              width: 400,
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Contact Us',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.white)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white)),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Required*';
                        } else if (!EmailValidator.validate(email)) {
                          return 'Please enter a valid Email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: messageController,
                      decoration: const InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(color: Colors.white)),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 45,
                      width: 110,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xff151534),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await sendEmail(
                                nameController.value.text,
                                emailController.value.text,
                                messageController.value.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              response == 200
                                  ? const SnackBar(
                                      content: Text('Message Sent!'),
                                      backgroundColor: Colors.deepPurple)
                                  : const SnackBar(
                                      content: Text('Failed to send message!'),
                                      backgroundColor: Colors.red),
                            );
                            nameController.clear();
                            emailController.clear();
                            messageController.clear();
                          }
                        },
                        child:
                            const Text('Send', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

Future sendEmail(String name, String email, String message) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': "",
        'template_id': "",
        'user_id': "",
        'template_params': {
          'from_name': name,
          'from_email': email,
          'message': message
        }
      }));
  return response.statusCode;
}
