// ignore_for_file: library_private_types_in_public_api, unused_field, avoid_returning_null_for_void, use_build_context_synchronously
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import '../utils/responsive.dart';

class SectionTextAndImageInput extends StatefulWidget {
  const SectionTextAndImageInput({super.key});

  @override
  State<SectionTextAndImageInput> createState() =>
      _SectionTextAndImageInputState();
}

class _SectionTextAndImageInputState extends State<SectionTextAndImageInput> {
  final ImagePicker picker = ImagePicker();
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result;
  bool _loading = false;

  Uint8List? selectedImage;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);

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
          mobile: Column(
            children: [
              if (searchedText != null)
                Padding(
                  padding: EdgeInsets.only(left: 2.w, top: 3.h, bottom: 1.h),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onLongPress: () {
                        FlutterClipboard.copy("$searchedText");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Copied")));
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'YOU:',
                            style: GoogleFonts.ubuntu(
                                color: Colors.amber,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: ' $searchedText',
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: loading
                                ? LoadingAnimationWidget.prograssiveDots(
                                    size: 20.w, color: Colors.white)
                                : result != null
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 2.w),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: GestureDetector(
                                              onLongPress: () {
                                                FlutterClipboard.copy(
                                                    "$result");
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                                "Copied")));
                                              },
                                              child: AnimatedTextKit(
                                                animatedTexts: [
                                                  TypewriterAnimatedText(
                                                    "$result",
                                                    textStyle:
                                                        GoogleFonts.ubuntu(
                                                            color: Colors.white,
                                                            fontSize: 8.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                                repeatForever: false,
                                                isRepeatingAnimation: false,
                                              ),
                                            )))
                                    : Center(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 10.h,
                                              width: 10.w,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle),
                                              child: Image.asset(
                                                  "assets/logo3.png"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 2.h),
                                              child: Text(
                                                  'How can I help you today?',
                                                  style: GoogleFonts.ubuntu(
                                                      color: Colors.white,
                                                      fontSize: 8.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                      ),
                          ),
                          if (selectedImage != null)
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: Image.memory(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 3.h),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(1.w)),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 50.h,
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
                                  fontSize: 8.sp),
                              decoration: InputDecoration(
                                  hintText: "Put your image",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 7.sp,
                                      fontWeight: FontWeight.bold),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          IconButton(
                              color: Colors.deepPurple,
                              onPressed: () async {
                                // Capture a photo.
                                final XFile? photo = await picker.pickImage(
                                    source: ImageSource.gallery);

                                if (photo != null) {
                                  photo
                                      .readAsBytes()
                                      .then((value) => setState(() {
                                            selectedImage = value;
                                          }));
                                }
                              },
                              icon: Icon(
                                EvaIcons.image,
                                size: 4.h,
                                color: Colors.white,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty &&
                                      selectedImage != null) {
                                    searchedText = controller.text;
                                    controller.clear();
                                    loading = true;

                                    gemini
                                        .textAndImage(
                                            text: searchedText!,
                                            image: selectedImage!)
                                        .then((value) {
                                      result = value?.content?.parts?.last.text;
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
                                    "prompt": searchedText,
                                  });
                                },
                                icon: Icon(
                                  EvaIcons.arrowCircleUp,
                                  size: 4.h,
                                  color: Colors.white,
                                )),
                          ),
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
            ], /////////////////////////////////////DESKTOP///////////////////////////////////////////////////////////
          ),
          desktop: Column(
            children: [
              if (searchedText != null)
                Padding(
                  padding: EdgeInsets.only(left: 2.w, top: 3.h),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onLongPress: () {
                        FlutterClipboard.copy("$searchedText");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Copied")));
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'YOU:',
                            style: GoogleFonts.ubuntu(
                                color: Colors.amber,
                                fontSize: 3.sp,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: ' $searchedText',
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 3.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: loading
                                ? LoadingAnimationWidget.prograssiveDots(
                                    size: 7.w, color: Colors.white)
                                : result != null
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 2.w),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: GestureDetector(
                                            onLongPress: () {
                                              FlutterClipboard.copy("$result");
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text("Copied")));
                                            },
                                            child: AnimatedTextKit(
                                              animatedTexts: [
                                                TypewriterAnimatedText(
                                                  "$result",
                                                  textStyle: GoogleFonts.ubuntu(
                                                      color: Colors.white,
                                                      fontSize: 3.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                              repeatForever: false,
                                              isRepeatingAnimation: false,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 10.h,
                                              width: 10.w,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle),
                                              child: Image.asset(
                                                  "assets/logo3.png"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 2.h),
                                              child: Text(
                                                  'How can I help you today?',
                                                  style: GoogleFonts.ubuntu(
                                                      color: Colors.white,
                                                      fontSize: 6.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                      ),
                          ),
                          if (selectedImage != null)
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: SizedBox(
                                  height: 70.h,
                                  width: 90.w,
                                  child: Image.memory(
                                    selectedImage!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
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
                                  hintText: "Put your image",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 3.sp,
                                      fontWeight: FontWeight.bold),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          IconButton(
                              color: Colors.deepPurple,
                              onPressed: () async {
                                // Capture a photo.
                                final XFile? photo = await picker.pickImage(
                                    source: ImageSource.gallery);

                                if (photo != null) {
                                  photo
                                      .readAsBytes()
                                      .then((value) => setState(() {
                                            selectedImage = value;
                                          }));
                                }
                              },
                              icon: Icon(
                                EvaIcons.image,
                                size: 4.h,
                                color: Colors.white,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty &&
                                      selectedImage != null) {
                                    searchedText = controller.text;
                                    controller.clear();
                                    loading = true;

                                    gemini
                                        .textAndImage(
                                            text: searchedText!,
                                            image: selectedImage!)
                                        .then((value) {
                                      result = value?.content?.parts?.last.text;
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
                                    "prompt": searchedText,
                                  });
                                },
                                icon: Icon(
                                  EvaIcons.arrowCircleUp,
                                  size: 4.h,
                                  color: Colors.white,
                                )),
                          ),
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
