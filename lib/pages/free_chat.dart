// ignore_for_file: use_build_context_synchronously
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import '../models/user.dart';
import '../utils/responsive.dart';

class SectionChat extends StatefulWidget {
  final AppUserData userData;
  const SectionChat({required this.userData, super.key});

  @override
  State<SectionChat> createState() => _SectionChatState();
}

class _SectionChatState extends State<SectionChat> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);
  final List<Content> chats = [];

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
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                elevation: 0,
                title: Text("Veebble AI",
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold)),
                backgroundColor: Colors.grey[900],
              )
            : null,
        body: ResponsiveWidget(
          mobile: Column(children: [
            Expanded(
                child: chats.isNotEmpty
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          reverse: false,
                          child: ListView.builder(
                            itemBuilder: chatItem,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: chats.length,
                            reverse: false,
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
                                const BoxDecoration(shape: BoxShape.circle),
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
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 50.h,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(1.w)),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: controller,
                              maxLines: null,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.sp),
                              decoration: InputDecoration(
                                  hintText: "Message veebble",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 7.sp,
                                      fontWeight: FontWeight.bold),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    final searchedText = controller.text;
                                    chats.add(Content(
                                        role: 'user',
                                        parts: [Parts(text: searchedText)]));
                                    controller.clear();
                                    loading = true;

                                    gemini.chat(chats).then((value) {
                                      chats.add(Content(
                                          role: 'model',
                                          parts: [Parts(text: value?.output)]));
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
                                    "uid":
                                        FirebaseAuth.instance.currentUser!.uid,
                                    "prompt": controller.text,
                                  });
                                },
                                icon: loading
                                    ? LoadingAnimationWidget.beat(
                                        size: 5.w,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        EvaIcons.arrowCircleUp,
                                        size: 4.h,
                                        color: Colors.white,
                                      )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )), ////////////////////////////////////////////////// DESKTOP///////////////////////////////////////////////////
            Padding(
              padding: EdgeInsets.only(bottom: 7.h, top: 1.h),
              child: Text(
                "VeebbleAI may display inaccurate information, including about people. So check his answers",
                style: TextStyle(color: Colors.grey, fontSize: 5.sp),
              ),
            )
          ]),
          desktop: Column(children: [
            Expanded(
                child: chats.isNotEmpty
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          reverse: false,
                          child: ListView.builder(
                            itemBuilder: chatItem,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: chats.length,
                            reverse: false,
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
                                const BoxDecoration(shape: BoxShape.circle),
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
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 3.h),
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
                                  hintText: "Message veebble",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 3.sp,
                                      fontWeight: FontWeight.bold),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    final searchedText = controller.text;
                                    chats.add(Content(
                                        role: 'user',
                                        parts: [Parts(text: searchedText)]));
                                    controller.clear();
                                    loading = true;

                                    gemini.chat(chats).then((value) {
                                      chats.add(Content(
                                          role: 'model',
                                          parts: [Parts(text: value?.output)]));
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
                                    "uid":
                                        FirebaseAuth.instance.currentUser!.uid,
                                    "prompt": controller.text,
                                  });
                                },
                                icon: loading
                                    ? LoadingAnimationWidget.beat(
                                        size: 2.w,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        EvaIcons.arrowCircleUp,
                                        size: 4.h,
                                        color: Colors.white,
                                      )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 7.h, top: 1.h),
              child: Text(
                "VeebbleAI may display inaccurate information, including about people. So check his answers",
                style: TextStyle(color: Colors.grey, fontSize: 2.5.sp),
              ),
            )
          ]),
        ));
  }

  Widget chatItem(BuildContext context, int index) {
    final Content content = chats[index];

    return ResponsiveWidget(
      mobile: Padding(
        padding: EdgeInsets.all(0.5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: content.role != 'model'
                  ? Image.asset(
                      ("assets/logo3.png"),
                      height: 4.h,
                    )
                  : Image.asset(
                      ("assets/logo2.png"),
                      height: 4.h,
                    ),
              title: content.role != 'model'
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
            ),
            Padding(
              padding: EdgeInsets.only(left: 11.w, right: 5.w, bottom: 2.h),
              child: content.role != 'model'
                  ? Text(
                      content.parts?.lastOrNull?.text ??
                          'cannot generate data!',
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 7.8.sp,
                          fontWeight: FontWeight.bold))
                  : AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          content.parts?.lastOrNull?.text ??
                              'cannot generate data!',
                          textStyle: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 7.8.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                      repeatForever: false,
                      isRepeatingAnimation: false,
                    ),
            ),
          ],
        ), /////////////////////////////////////////////DESKTOP////////////////////////////////////////////////////////
      ),
      desktop: Padding(
        padding: EdgeInsets.only(left: 1.w, right: 1.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: content.role != 'model'
                  ? Image.asset(
                      ("assets/logo3.png"),
                      height: 4.h,
                    )
                  : Image.asset(
                      ("assets/logo2.png"),
                      height: 4.h,
                    ),
              title: content.role != 'model'
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
                    FlutterClipboard.copy("${content.parts?.lastOrNull?.text}");
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Copied")));
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Colors.white,
                    size: 1.w,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 1.w, bottom: 1.h),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    content.parts?.lastOrNull?.text ?? 'cannot generate data!',
                    textStyle: GoogleFonts.ubuntu(
                        color: Colors.white,
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
