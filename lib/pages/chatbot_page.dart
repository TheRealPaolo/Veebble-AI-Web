// ignore_for_file: depend_on_referenced_packages, unused_import, prefer_const_constructors, avoid_print, library_private_types_in_public_api, prefer_final_fields, unnecessary_null_comparison, unnecessary_string_interpolations, avoid_returning_null_for_void, use_build_context_synchronously
import 'dart:convert';
import 'dart:typed_data';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/user.dart';
import '../services/authentication.dart';
import '../templates/login2.dart';
import '../templates/settings.dart';
import '../utils/responsive.dart';

class MyHomePage extends StatefulWidget {
  final AppUserData userData;
  const MyHomePage({required this.userData, super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);
  // MY APP COPYRIGHT WEB SITE URL

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MediaQuery.of(context).size.width < 340 ||
                MediaQuery.of(context).size.width < 930
            ? Colors.black
            : Colors.transparent,
        appBar: MediaQuery.of(context).size.width < 340 ||
                MediaQuery.of(context).size.width < 930
            ? AppBar(
                leading: MediaQuery.of(context).size.width < 340 ||
                        MediaQuery.of(context).size.width < 930
                    ? IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ))
                    : SizedBox.shrink(),
                elevation: 0,
                title: Text("Veebble AI",
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold)),
                backgroundColor: Colors.grey[900],
              )
            : null,
        body: ResponsiveWidget(
          mobile: Column(
            children: [
              if (searchedText != null)
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: MaterialButton(
                      color: Colors.grey[800],
                      onPressed: () {
                        setState(() {
                          searchedText = null;
                          result = null;
                        });
                      },
                      child: searchedText == null
                          ? Text(
                              "Ask something",
                              style: GoogleFonts.aBeeZee(
                                color: Colors.white,
                                fontSize: 9.sp,
                              ),
                            )
                          : Text(
                              'Question: $searchedText',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.white,
                                fontSize: 9.sp,
                              ),
                            )),
                ),
              Expanded(
                  child: loading
                      ? LoadingAnimationWidget.prograssiveDots(
                          size: 9.w, color: Colors.white)
                      : result != null
                          ? SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 3.w,
                                    right: 3.w,
                                    top: 3.h,
                                    bottom: 3.h),
                                child: GestureDetector(
                                  onLongPress: () {
                                    FlutterClipboard.copy("$result");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Copied")));
                                  },
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText("$result",
                                          textStyle: GoogleFonts.aBeeZee(
                                            color: Colors.white,
                                            fontSize: 8.sp,
                                          )),
                                    ],
                                    repeatForever: false,
                                    isRepeatingAnimation: false,
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 10.h,
                                  width: 10.w,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Image.asset("assets/logo3.png"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Text('How can I help you today?',
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.white,
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ))),
              Padding(
                padding: EdgeInsets.only(
                    left: 8.w, right: 8.w, bottom: 2.h, top: 3.h),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 50.h,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: controller,
                              maxLines: null,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp),
                              decoration: InputDecoration(
                                  hintText: "Message veebble...",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          _isLoading
                              ? Padding(
                                  padding: EdgeInsets.only(right: 1.w),
                                  child: LoadingAnimationWidget.beat(
                                    size: 2.w,
                                    color: Colors.white,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    if (controller.text.isNotEmpty) {
                                      searchedText = controller.text;
                                      controller.clear();
                                      loading = true;

                                      gemini.text(searchedText!).then((value) {
                                        result =
                                            value?.content?.parts?.last.text;
                                        loading = false;
                                      });
                                    }
                                    FirebaseFirestore.instance
                                        .collection("Prompts")
                                        .doc()
                                        .set({
                                      "name": FirebaseAuth
                                          .instance.currentUser!.displayName,
                                      "email": FirebaseAuth
                                          .instance.currentUser!.email,
                                      "uid": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "prompt": searchedText,
                                    });
                                  },
                                  icon: Icon(
                                    EvaIcons.arrowCircleUp,
                                    size: 4.h,
                                    color: Colors.white,
                                  )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 7.h, top: 1.h),
                child: Text(
                  "VeebbleAI may display inaccurate information, including about people. So check his answers",
                  style: TextStyle(color: Colors.grey, fontSize: 5.sp),
                ),
              )
            ],
          ),
          ///////////////////////////DEKSTOP///////////////////////////////////////////////////////////////////////////////////////////

          desktop: Column(
            children: [
              if (searchedText != null) SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: MaterialButton(
                    color: Colors.grey[800],
                    onPressed: () {
                      setState(() {
                        searchedText = null;
                        result = null;
                      });
                    },
                    child: searchedText == null
                        ? Text(
                            "Ask something",
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 3.sp,
                            ),
                          )
                        : Text(
                            'Question: $searchedText',
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 4.sp,
                            ),
                          )),
              ),
              Expanded(
                  child: loading
                      ? LoadingAnimationWidget.prograssiveDots(
                          size: 7.w, color: Colors.white)
                      : result != null
                          ? SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 3.w,
                                    right: 3.w,
                                    top: 3.h,
                                    bottom: 3.h),
                                child: GestureDetector(
                                  onLongPress: () {
                                    FlutterClipboard.copy("$result");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Copied")));
                                  },
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText("$result",
                                          textStyle: GoogleFonts.aBeeZee(
                                            color: Colors.white,
                                            fontSize: 4.sp,
                                          )),
                                    ],
                                    repeatForever: false,
                                    isRepeatingAnimation: false,
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 10.h,
                                  width: 10.w,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Image.asset("assets/logo3.png"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Text('How can I help you today?',
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.white,
                                          fontSize: 6.sp,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ))),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.w, right: 15.w, bottom: 1.h, top: 3.h),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 50.h,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: controller,
                              maxLines: null,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 3.sp),
                              decoration: InputDecoration(
                                  hintText: "Message veebble...",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 3.sp,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          _isLoading
                              ? Padding(
                                  padding: EdgeInsets.only(right: 1.w),
                                  child: LoadingAnimationWidget.beat(
                                    size: 2.w,
                                    color: Colors.white,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () async {
                                    if (controller.text.isNotEmpty) {
                                      searchedText = controller.text;
                                      controller.clear();
                                      loading = true;

                                      gemini.text(searchedText!).then((value) {
                                        result =
                                            value?.content?.parts?.last.text;
                                        loading = false;
                                      });
                                    }
                                    FirebaseFirestore.instance
                                        .collection("Prompts")
                                        .doc()
                                        .set({
                                      "name": FirebaseAuth
                                          .instance.currentUser!.displayName,
                                      "email": FirebaseAuth
                                          .instance.currentUser!.email,
                                      "uid": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "prompt": searchedText,
                                    });
                                  },
                                  icon: Icon(
                                    EvaIcons.arrowCircleUp,
                                    size: 4.h,
                                    color: Colors.white,
                                  )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 7.h, top: 1.h),
                child: Text(
                  "VeebbleAI may display inaccurate information, including about people. So check his answers",
                  style: TextStyle(color: Colors.grey, fontSize: 2.5.sp),
                ),
              )
            ],
          ),
        ));
  }
}

class ChatMessage extends StatelessWidget {
  final String name;
  final String text;
  final ChatMessageType type;

  const ChatMessage(
      {super.key, required this.name, required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.all(1.w),
                child: ListTile(
                  leading: type == ChatMessageType.user
                      ? ProfilePicture(
                          name: '${name[0]}',
                          radius: 5.w,
                          fontsize: 21,
                          count: 2,
                        )
                      : Image.asset(
                          ("assets/logo3.png"),
                          height: 4.h,
                        ),
                  title: type == ChatMessageType.user
                      ? Text(
                          "YOU",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 6.sp,
                              fontWeight: FontWeight.bold),
                        )
                      : Text("VEEBBLE",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 6.sp,
                              fontWeight: FontWeight.bold)),
                  trailing: IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(text);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Copied")));
                      },
                      icon: Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 3.w,
                      )),
                )),
            type == ChatMessageType.user
                ? Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 10.w),
                    child: Text(
                      "$text",
                      style: GoogleFonts.ubuntu(
                          color: type == ChatMessageType.user
                              ? Colors.white
                              : Colors.white,
                          fontSize: 7.8.sp,
                          fontWeight: FontWeight.bold),
                    ))
                : Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 5.w),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "$text",
                          textStyle: GoogleFonts.ubuntu(
                              color: type == ChatMessageType.user
                                  ? Colors.white
                                  : Colors.white,
                              fontSize: 7.8.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                      repeatForever: false,
                      isRepeatingAnimation: false,
                    ),
                  ),
          ],
        ),
      ), ///////////////////////////////////DESKTOP///////////////////////////////////////
      desktop: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 1.w, right: 1.w),
                child: ListTile(
                  leading: type == ChatMessageType.user
                      ? ProfilePicture(
                          name: '${name[0]}',
                          radius: 1.w,
                          fontsize: 10,
                          count: 2,
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Image.asset(
                            ("assets/logo3.png"),
                            height: 4.h,
                          ),
                        ),
                  title: type == ChatMessageType.user
                      ? Text(
                          "YOU",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 2.5.sp,
                              fontWeight: FontWeight.bold),
                        )
                      : Text("VEEBBLE",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 2.5.sp,
                              fontWeight: FontWeight.bold)),
                  trailing: IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(text);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Copied")));
                      },
                      icon: Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 1.w,
                      )),
                )),
            type == ChatMessageType.user
                ? Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 1.w),
                    child: Text(
                      "$text",
                      style: GoogleFonts.ubuntu(
                          color: type == ChatMessageType.user
                              ? Colors.white
                              : Colors.white,
                          fontSize: 3.sp,
                          fontWeight: FontWeight.bold),
                    ))
                : Padding(
                    padding: EdgeInsets.only(left: 6.5.w, right: 1.w),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "$text",
                          textStyle: GoogleFonts.ubuntu(
                              color: type == ChatMessageType.user
                                  ? Colors.white
                                  : Colors.white,
                              fontSize: 3.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                      repeatForever: false,
                      isRepeatingAnimation: false,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

enum ChatMessageType { user, bot }
