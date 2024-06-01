// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print, unrelated_type_equality_checks, deprecated_member_use, prefer_final_fields, unused_field
import 'dart:async';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veebble_web/utils/country.dart';
import 'package:video_player/video_player.dart';
import '../services/authentication.dart';
import '../utils/contact.dart';
import '../utils/responsive.dart';

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  _Login2State createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        "https://firebasestorage.googleapis.com/v0/b/lira-1a32f.appspot.com/o/Green%20Elegant%20Minimal%20Beauty%20Influencer%20Thanks%20for%20Watching%20Youtube%20Video%20Outro%20(online-video-cutter.com).mp4?alt=media&token=7fe3efd1-bd72-4bbd-94fc-c0827e05eaec"))
      ..setLooping(true)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller!.play();
        _controller!.setPlaybackSpeed(1.0);
        _controller!.setVolume(0.0);
      });
  }

///// BODY FULL DU PROGRAMME
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIsWeb ? Colors.black : Colors.black,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResponsiveWidget(
                  mobile: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Color.fromARGB(35, 158, 158, 158),
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.black,
                      ],
                    )),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppBar(
                            backgroundColor:
                                const Color.fromARGB(255, 10, 0, 24),
                            elevation: 0,
                            leading: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/logo3.png"),
                              ),
                            ),
                            title: Padding(
                              padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                              child: Text(
                                "Veebble AI",
                                style: GoogleFonts.oswald(
                                    fontSize: 10.sp, color: Colors.white),
                              ),
                            ),
                            actions: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const Support()));
                                  },
                                  child: Icon(
                                    EvaIcons.globe,
                                    color: Colors.blue,
                                    size: 5.w,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const Support()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Text(
                                    "Country Support",
                                    style: GoogleFonts.oswald(
                                        fontSize: 8.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                                child: VerticalDivider(
                                  color: Colors.grey[800],
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EmailPage()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 1.w),
                                  child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Contact us",
                                        style: GoogleFonts.oswald(
                                            fontSize: 8.sp,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, right: 2.w),
                                child: SizedBox(
                                    height: 30.h,
                                    width: 100.w,
                                    child: _controller!.value.isInitialized &&
                                            _controller!.value.isPlaying
                                        ? AspectRatio(
                                            aspectRatio:
                                                _controller!.value.aspectRatio,
                                            child: VideoPlayer(_controller!),
                                          )
                                        : Image.asset(
                                            "assets/def.jpg",
                                            fit: BoxFit.contain,
                                          )),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 2.h, left: 5.w),
                                  child: Text(
                                    "Join us now",
                                    style: GoogleFonts.cinzelDecorative(
                                        fontSize: 15.sp,
                                        color: const Color.fromARGB(
                                            255, 243, 236, 185),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 2.h, left: 5.w),
                                  child: Text(
                                    "Sign in ",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 15.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    left: 7.w, right: 7.w, top: 5.h),
                                child: MaterialButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 7.w,
                                            top: 1.5.h,
                                            bottom: 1.5.h),
                                        child: Image.asset(
                                          "assets/G.png",
                                          height: 5.w,
                                        ),
                                      ),
                                      Text(
                                        "Sign in with Google",
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 10.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    AuthenticationService auth =
                                        AuthenticationService();
                                    await auth.signInWithGoogle(context);
                                  },
                                ),
                              ),
                              // CONNCETION WITH GITHUB
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 7.w, right: 7.w, top: 2.h),
                                child: MaterialButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 7.w,
                                            top: 1.5.h,
                                            bottom: 1.5.h),
                                        child: Image.asset(
                                          "assets/github.png",
                                          height: 5.w,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Sign in with Github",
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 10.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    final auth = AuthenticationService();
                                    auth.signInWithGitHub(context);
                                  },
                                ),
                              ),

                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 5.w, right: 5.w, top: 3.h),
                                  child: TextButton(
                                      onPressed: () {
                                        _launchUrl();
                                      },
                                      child: RichText(
                                          text: TextSpan(
                                              text:
                                                  'By signing up, you agree to our',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8.sp),
                                              children: [
                                            TextSpan(
                                              text: ' Terms of Service',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 8.sp),
                                            ),
                                            TextSpan(
                                              text: ' and acknowledge that our',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8.sp),
                                            ),
                                            TextSpan(
                                              text: ' Privacy Policy',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 8.sp),
                                            ),
                                            TextSpan(
                                              text: ' applies to you',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8.sp),
                                            )
                                          ])))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 3.h, right: 1.w),
                                    child: GestureDetector(
                                      onTap: () {
                                        _launchUrlX();
                                      },
                                      child: Image.asset(
                                        "assets/xx.png",
                                        height: 5.h,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 3.h, left: 1.w),
                                    child: GestureDetector(
                                      onTap: () {
                                        _launchUrlT();
                                      },
                                      child: Image.asset(
                                        "assets/tele.png",
                                        height: 5.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w, right: 5.w, top: 3.h),
                                child: Divider(
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          //////////// FIRST DATA ON MOBILE
                          Text(
                            "Use Veebble AI today for image analysis",
                            style: GoogleFonts.oswald(
                                color: const Color.fromARGB(255, 243, 236, 185),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.h, left: 5.w, right: 5.w),
                            child: Text(
                              "Highly advanced image analysis",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 1.h, left: 5.w, right: 5.w),
                            child: Text(
                              "with great attention to detail",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 1.h, left: 5.w, right: 5.w),
                            child: Text(
                              "Image any context of the image in any language",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 1.h, left: 5.w, right: 5.w),
                            child: Text(
                              "get an answer in a few seconds",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h, top: 2.h),
                            child: SizedBox(
                              height: 30.h,
                              width: 96.w,
                              child: Image.asset(
                                "assets/D1.jpg",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ), /////////////SECOND DATA ON MOBILE
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Divider(
                              color: Colors.grey[900],
                            ),
                          ),

                          Text(
                            "Ask your question and search anything you want",
                            style: GoogleFonts.oswald(
                                color: const Color.fromARGB(255, 243, 236, 185),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.h, left: 5.w, right: 5.w),
                            child: Text(
                              "English, French, German, Portuguese, and more...",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 1.h, left: 5.w, right: 5.w),
                            child: Text(
                              "Veebble AI supports 38 languages in any context ",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 1.h, left: 5.w, right: 5.w),
                            child: Text(
                              "Get an answer in a few seconds",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 2.h, top: 1.h, left: 2.h, right: 2.h),
                            child: SizedBox(
                              height: 30.h,
                              width: 96.w,
                              child: Image.asset(
                                "assets/D2.jpg",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          //////////////////////// THIRD DATA ON MOBILE
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Divider(
                              color: Colors.grey[900],
                            ),
                          ),
                          Text(
                            "Let have a Veebble AI today",
                            style: GoogleFonts.oswald(
                                color: const Color.fromARGB(255, 243, 236, 185),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.h, left: 5.w, right: 5.w),
                            child: Text(
                              "Enjoy your free conversation with Veebble AI",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 1.h, left: 5.w, right: 5.w),
                            child: Text(
                              "Chat in any language you want and have fun",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 1.h, left: 5.w, right: 5.w),
                            child: Text(
                              "Get an answer in a few seconds",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 2.h, top: 1.h, left: 2.h, right: 2.h),
                            child: SizedBox(
                              height: 30.h,
                              width: 96.w,
                              child: Image.asset(
                                "assets/D3.jpg",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Divider(
                              color: Colors.grey[800],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, right: 5.w, top: 1.h),
                              child: TextButton(
                                  onPressed: () {
                                    _launchUrl();
                                  },
                                  child: RichText(
                                      text: TextSpan(
                                          text:
                                              'By signing up, you agree to our',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8.sp),
                                          children: [
                                        TextSpan(
                                          text: ' Terms of Service',
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 8.sp),
                                        ),
                                        TextSpan(
                                          text: ' and acknowledge that our',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8.sp),
                                        ),
                                        TextSpan(
                                          text: ' Privacy Policy',
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 8.sp),
                                        ),
                                        TextSpan(
                                          text: ' applies to you',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8.sp),
                                        )
                                      ])))),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h, top: 2.h),
                            child: Text(
                              "© Veebble AI, 2024",
                              style: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 10.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  ), /////////////////////////////DESKSTOP UI DESIGN /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  desktop: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Color.fromARGB(35, 158, 158, 158),
                        Colors.black,
                        Colors.black,
                      ],
                    )),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppBar(
                            backgroundColor:
                                const Color.fromARGB(255, 10, 0, 24),
                            elevation: 0,
                            leading: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/logo3.png"),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Veebble AI",
                                style: GoogleFonts.oswald(
                                    fontSize: 4.sp, color: Colors.white),
                              ),
                            ),
                            actions: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const Support()));
                                  },
                                  child: Icon(
                                    EvaIcons.globe,
                                    color: Colors.blue,
                                    size: 2.5.w,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const Support()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Text(
                                    "Country Support",
                                    style: GoogleFonts.oswald(
                                        fontSize: 4.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _launchUrlT();
                                },
                                child: Image.asset(
                                  "assets/tele.png",
                                  height: 4.h,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _launchUrlT();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Text(
                                    "Telegram community",
                                    style: GoogleFonts.oswald(
                                        fontSize: 4.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                                child: VerticalDivider(
                                  color: Colors.grey[800],
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EmailPage()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 1.w),
                                  child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Contact",
                                        style: GoogleFonts.oswald(
                                            fontSize: 3.5.sp,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 80.h,
                                      width: 45.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 2.h, left: 5.w),
                                              child: Text(
                                                "Join us now",
                                                style: GoogleFonts.oswald(
                                                    fontSize: 7.sp,
                                                    color: const Color.fromARGB(
                                                        255, 243, 236, 185),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0.h, left: 5.w),
                                              child: Text(
                                                "Sign in ",
                                                style: GoogleFonts.aBeeZee(
                                                    fontSize: 7.sp,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 5.w,
                                                right: 5.w,
                                                top: 5.h),
                                            child: MaterialButton(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 7.w,
                                                        top: 0.5.h,
                                                        bottom: 0.5.h),
                                                    child: Image.asset(
                                                      "assets/G.png",
                                                      height: 3.w,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Sign in with Google",
                                                    style: GoogleFonts.aBeeZee(
                                                        fontSize: 5.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              onPressed: () async {
                                                AuthenticationService auth =
                                                    AuthenticationService();
                                                await auth
                                                    .signInWithGoogle(context);
                                              },
                                            ),
                                          ),
                                          // CONNCETION WITH GITHUB
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 5.w,
                                                right: 5.w,
                                                top: 2.h),
                                            child: MaterialButton(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 7.w,
                                                          top: 0.5.h,
                                                          bottom: 0.5.h),
                                                      child: Image.asset(
                                                        "assets/github.png",
                                                        height: 3.w,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Sign in with Github",
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                              fontSize: 5.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () async {
                                                  final auth =
                                                      AuthenticationService();
                                                  auth.signInWithGitHub(
                                                      context);
                                                }),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5.w,
                                                  right: 5.w,
                                                  top: 3.h),
                                              child: TextButton(
                                                  onPressed: () {
                                                    _launchUrl();
                                                  },
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text:
                                                              'By signing up, you agree to our',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 3.sp),
                                                          children: [
                                                        TextSpan(
                                                          text:
                                                              ' Terms of Service',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.amber,
                                                              fontSize: 3.sp),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' and acknowledge that our',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 3.sp),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' Privacy Policy',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.amber,
                                                              fontSize: 3.sp),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' applies to you',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 3.sp),
                                                        )
                                                      ])))),

                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 5.w,
                                                right: 5.w,
                                                top: 5.h),
                                            child: Divider(
                                              color: Colors.grey[900],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _launchUrlX();
                                            },
                                            child: Image.asset(
                                              "assets/xx.png",
                                              height: 5.h,
                                            ),
                                          )
                                        ],
                                      ),
                                    ), //////////////////////////////////
                                    SizedBox(
                                      height: 80.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 6.h, right: 2.w),
                                            child: SizedBox(
                                                height: 50.h,
                                                width: 60.w,
                                                child:
                                                    _controller!.value.isPlaying
                                                        ? _controller!.value
                                                                .isInitialized
                                                            ? AspectRatio(
                                                                aspectRatio:
                                                                    _controller!
                                                                        .value
                                                                        .aspectRatio,
                                                                child: VideoPlayer(
                                                                    _controller!),
                                                              )
                                                            : const SizedBox
                                                                .shrink()
                                                        : Image.asset(
                                                            "assets/def.jpg",
                                                            fit: BoxFit.contain,
                                                          )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                ///////////////////////////////////FIRST DATA PLACE//////////////////////////////////////////////////////////////////
                                Text(
                                  "Use Veebble AI today for image analysis",
                                  style: GoogleFonts.oswald(
                                      color: const Color.fromARGB(
                                          255, 243, 236, 185),
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.bold),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: 5.h),
                                  child: Text(
                                    "Highly advanced image analysis with great attention to detail",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 3.sp, color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h),
                                  child: Text(
                                    "Image any context of the image in any language",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 3.sp, color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h),
                                  child: Text(
                                    " ask all your questions and get an answer in a few seconds",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 3.sp, color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 2.h, top: 2.h),
                                  child: SizedBox(
                                    height: 70.h,
                                    width: 80.w,
                                    child: Image.asset(
                                      "assets/D1.jpg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ///////////////////////////////////////////////////////SECOND ZONE DATA//////////////////////////////////////////////////////////
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Divider(
                              color: Colors.grey[900],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 80.h,
                                      width: 45.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Ask your question and search anything you want",
                                            style: GoogleFonts.oswald(
                                                color: const Color.fromARGB(
                                                    255, 243, 236, 185),
                                                fontSize: 5.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 5.h),
                                            child: Text(
                                              "English, French, German, Portuguese, Italian, Spain and more...",
                                              style: GoogleFonts.aBeeZee(
                                                  fontSize: 3.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 1.h),
                                            child: Text(
                                              "Veebble AI supports 38 languages in any context ",
                                              style: GoogleFonts.aBeeZee(
                                                  fontSize: 3.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 1.h),
                                            child: Text(
                                              " Ask all your questions and get an answer in a few seconds",
                                              style: GoogleFonts.aBeeZee(
                                                  fontSize: 3.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ), //////////////////////////////////
                                    SizedBox(
                                      height: 80.h,
                                      width: 55.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 15.h, right: 2.w),
                                            child: SizedBox(
                                                height: 50.h,
                                                width: 60.w,
                                                child: Image.asset(
                                                  "assets/D2.jpg",
                                                  fit: BoxFit.contain,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /////////////////////////////////////// THIRD ZONE DATA ////////////////////////////////////////////////////////////////////////////////
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Divider(
                              color: Colors.grey[900],
                            ),
                          ),
                          Text(
                            "Let have a Veebble AI today",
                            style: GoogleFonts.oswald(
                                color: const Color.fromARGB(255, 243, 236, 185),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.bold),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: Text(
                              "Enjoy your free conversation with Veebble AI",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 3.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Text(
                              "Chat in any language you want and have fun",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 3.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Text(
                              " Ask all your questions and get an answer in a few seconds",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 3.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h, top: 5.h),
                            child: SizedBox(
                              height: 60.h,
                              width: 80.w,
                              child: Image.asset(
                                "assets/D3.jpg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Divider(
                              color: Colors.grey[900],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, right: 5.w, top: 3.h, bottom: 1.h),
                              child: TextButton(
                                  onPressed: () {
                                    _launchUrl();
                                  },
                                  child: RichText(
                                      text: TextSpan(
                                          text:
                                              'By signing up, you agree to our',
                                          style: GoogleFonts.oswald(
                                              color: Colors.white,
                                              fontSize: 3.sp),
                                          children: [
                                        TextSpan(
                                          text: ' Terms of Service',
                                          style: GoogleFonts.oswald(
                                              color: Colors.amber,
                                              fontSize: 3.sp),
                                        ),
                                        TextSpan(
                                          text: ' and acknowledge that our',
                                          style: GoogleFonts.oswald(
                                              color: Colors.white,
                                              fontSize: 3.sp),
                                        ),
                                        TextSpan(
                                          text: ' Privacy Policy',
                                          style: GoogleFonts.oswald(
                                              color: Colors.amber,
                                              fontSize: 3.sp),
                                        ),
                                        TextSpan(
                                          text: ' applies to you',
                                          style: GoogleFonts.oswald(
                                              color: Colors.white,
                                              fontSize: 3.sp),
                                        )
                                      ])))),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Text(
                              "© Veebble AI, 2024",
                              style: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 3.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),

              ///////////////////////////////// NO DESKTOP ZONE//////////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }

  // MY APP COPYRIGHT WEB SITE URL
  final Uri _url = Uri.parse(
      'https://www.freeprivacypolicy.com/live/da91eeae-ee8f-4f03-87e8-b89f1e9cf689');

  // FUNCTION TO LAUNCH URL WEB COPYRIGHTS
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  // MY X(TWITTER) ACCOUNT URL
  final Uri _urlX =
      Uri.parse('https://x.com/VeebbleAIApp?t=RMRfCN-q6-6_KWlfN4HX8w&s=09');

  // FUNCTION TO LAUNCH URL TWITTER
  Future<void> _launchUrlX() async {
    if (!await launchUrl(_urlX)) {
      throw Exception('Could not launch $_url');
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////

  // MY Telegram community ACCOUNT URL
  final Uri _urlT = Uri.parse('https://t.me/+khedtgzfJ7s3NWQ8');

  // FUNCTION TO LAUNCH URL Telegram community
  Future<void> _launchUrlT() async {
    if (!await launchUrl(_urlT)) {
      throw Exception('Could not launch $_url');
    }
  }
}
