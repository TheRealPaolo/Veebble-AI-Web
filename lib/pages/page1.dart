import 'package:banner_listtile/banner_listtile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sidebar_with_animation/animated_side_bar.dart';
import 'package:sizer/sizer.dart';
import '../models/user.dart';
import '../templates/settings.dart';
import '../utils/responsive.dart';
import 'chatbot_page.dart';
import 'chatbot_pro.dart';
import 'free_chat.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _AccueilState();
}

class _AccueilState extends State<Page1> {
  int value = 0;

  void tap(int s) {
    setState(() {
      value = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUserData>(context);

    List<Widget> sb = [
      MyHomePage(userData: user),
      const SectionTextAndImageInput(),
      SectionChat(userData: user),
      Parametre(
        email: "${user.email}",
        name: "${user.name}",
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 55, 54, 54),
        body: ResponsiveWidget(
          mobile: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, Colors.black, Colors.grey],
            )),
            child: Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Veebble AI",
                          style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold)),
                      leading: Padding(
                        padding: EdgeInsets.all(0.5.w),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Parametre(
                                          name: user.name!,
                                          email: user.email!,
                                        )));
                          },
                          child: ProfilePicture(
                            name: '${user.name}',
                            radius: 18,
                            fontsize: 21,
                            count: 1,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 3.w, right: 3.w, bottom: 2.h),
                      child: const Divider(
                        color: Color.fromARGB(106, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                        height: 30.h,
                        width: 90.w,
                        child: Image.asset(
                          'assets/D4.png',
                          fit: BoxFit.cover,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
                        child: TextButton(
                            onPressed: null,
                            child: RichText(
                                text: TextSpan(
                                    text: 'Explore the infinite',
                                    style: GoogleFonts.oswald(
                                        color: Colors.white, fontSize: 18.sp),
                                    children: [
                                  TextSpan(
                                    text: ' capabilities',
                                    style: GoogleFonts.oswald(
                                        color: Colors.amber, fontSize: 18.sp),
                                  ),
                                  TextSpan(
                                    text: ' of',
                                    style: GoogleFonts.oswald(
                                        color: Colors.white, fontSize: 18.sp),
                                  ),
                                  TextSpan(
                                    text: ' Veebble AI',
                                    style: GoogleFonts.oswald(
                                        color: Colors.amber, fontSize: 18.sp),
                                  ),
                                ])))),

                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 4.h),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: BannerListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MyHomePage(
                                          userData: user,
                                        )));
                          },
                          title: Text(
                              "Ask anything in anything language and get the answer in few seconds we support 38 languages",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold)),
                          showBanner: false,
                          imageContainerSize: 20.w,
                          backgroundColor: Colors.grey[800],
                          imageContainer: Card(
                              color: Colors.black,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 10.w,
                              )),
                        ),
                      ),
                    ),
/////////////////////////////////////////////////////////////////////////////////////////////////////////
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: BannerListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const SectionTextAndImageInput()));
                          },
                          title: Text(
                              "Very advanced image analysis with a keen sense of detail in every imaginable context",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold)),
                          showBanner: false,
                          imageContainerSize: 20.w,
                          backgroundColor: Colors.grey[800],
                          imageContainer: Card(
                              color: Colors.black,
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 10.w,
                              )),
                        ),
                      ),
                    ),

                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    Padding(
                      padding: EdgeInsets.only(
                          left: 5.w, right: 5.w, top: 2.h, bottom: 5.h),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: BannerListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SectionChat(
                                          userData: user,
                                        )));
                          },
                          title: Text(
                              "Have free and intuitive conversations without any limits of imagination, all in 38 languages ​​of course",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold)),
                          showBanner: false,
                          imageContainerSize: 20.w,
                          backgroundColor: Colors.grey[800],
                          imageContainer: Card(
                              color: Colors.black,
                              child: Icon(
                                CupertinoIcons.chat_bubble_fill,
                                color: Colors.white,
                                size: 10.w,
                              )),
                        ),
                      ),
                    ),
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  ],
                ),
              ),
            ), //////////////////// DESKTOP///////////////////////////////////////////////////////////////////////////////////////////////////
          ),
          desktop: Row(
            children: [
              SideBarAnimated(
                onTap: (s) {
                  setState(() {
                    value = s;
                  });
                },
                widthSwitch: 700,
                borderRadius: 20,
                mainLogoImage: 'assets/logo3.png',
                sidebarItems: [
                  SideBarItem(
                    iconSelected: Icons.question_answer,
                    iconUnselected: Icons.question_answer_outlined,
                    text: 'Ask Anything',
                  ),
                  SideBarItem(
                    iconSelected: Icons.image_rounded,
                    iconUnselected: Icons.image_outlined,
                    text: 'Image Analysis',
                  ),
                  SideBarItem(
                    iconSelected: CupertinoIcons.chat_bubble_fill,
                    iconUnselected: CupertinoIcons.chat_bubble,
                    text: 'Let Chat',
                  ),
                  SideBarItem(
                    iconSelected: Icons.settings,
                    iconUnselected: Icons.settings_outlined,
                    text: 'Settings',
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: sb.elementAt(value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
