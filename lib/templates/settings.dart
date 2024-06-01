// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veebble_web/utils/contact.dart';
import 'package:veebble_web/utils/responsive.dart';
import '../services/authentication.dart';

class Parametre extends StatefulWidget {
  final String name, email;
  const Parametre({required this.email, required this.name, super.key});

  @override
  _ParametreState createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  // MY APP COPYRIGHT WEB SITE URL
  final Uri _url = Uri.parse(
      'https://www.freeprivacypolicy.com/live/da91eeae-ee8f-4f03-87e8-b89f1e9cf689');

  // FUNCTION TO LAUNCH URL
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////

  // STRIPE PAY LINK
  final Uri _urlStripe = Uri.parse('https://buy.stripe.com/3cs7vQ9ebfUDf6weUU');

  // FUNCTION TO LAUNCH URL STRIPE PAY LINK
  Future<void> _launchUrlStripe() async {
    if (!await launchUrl(_urlStripe)) {
      throw Exception('Could not launch $_url');
    }
  }

  final List<String> allowedCountries = [
    "Albania",
    "Algeria",
    "American Samoa",
    "Angola",
    "Anguilla",
    "Antarctic",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Australia",
    "Azerbaijan",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belize",
    "Benign",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia Herzegovina",
    "Botswana",
    "Brazil",
    "British Indian Ocean Territory",
    "British Virgin Islands",
    "Brunei",
    "Burkina Faso",
    "Burundi",
    "Green cap",
    "Cambodia",
    "Cameroon",
    "Cayman Islands",
    "Central African Republic",
    "Chad",
    "Chile",
    "Christmas Island",
    "Cocos (Keeling) Islands",
    "Colombia",
    "Comoros",
    "Cook Islands",
    "Costa Rica",
    "Ivory Coast",
    "Democratic Republic of Congo",
    "Djibouti",
    "Dominic",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Eswatini",
    "Ethiopia",
    "Falkland Islands (Islas Malvinas)",
    "Faroe Islands",
    "Fiji",
    "Georgia",
    "Ghana",
    "Gibraltar",
    "Greenland",
    "Grenade",
    "Guam",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Heard Island and McDonald Islands",
    "Honduras",
    "India",
    "Indonesia",
    "Iraq",
    "Israel",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Burma",
    "Namibia",
    "Nauru",
    "Nepal",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Niue",
    "Norfolk Island",
    "North Macedonia",
    "Northern Mariana Islands",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Pitcairn Islands",
    "Porto Rico",
    "Qatar",
    "Republic of Congo",
    "Rwanda",
    "Saint Helena, Ascension and Tristan da Cunha",
    "Saint Kitts and Nevis",
    "St. LUCIA",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Georgia and the South Sandwich Islands",
    "South Korea",
    "South Sudan",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "The Bahamas",
    "The Gambia",
    "Timor-Leste",
    "Tokelau",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Türkiye",
    "Turkmenistan",
    "Turks and Caicos Islands",
    "Tuvalu",
    "US Virgin Islands",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "UNITED STATES",
    "United States Minor Outlying Islands",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Venezuela",
    "Vietnam",
    "Western Sahara",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];

  bool isUserAllowed(String userCountry) {
    // Vérifie si le pays de l'utilisateur existe dans la liste des pays autorisés
    return allowedCountries.contains(userCountry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 55, 54, 54),
        appBar: AppBar(
          leading: MediaQuery.of(context).size.width < 340 ||
                  MediaQuery.of(context).size.width < 930
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                )
              : SizedBox.shrink(),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: MediaQuery.of(context).size.width < 340 ||
                  MediaQuery.of(context).size.width < 930
              ? Text("Settings",
                  style: GoogleFonts.aBeeZee(
                      fontSize: MediaQuery.of(context).size.width < 340 ||
                              MediaQuery.of(context).size.width < 930
                          ? 10.sp
                          : 5.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white))
              : SizedBox.shrink(),
        ),
        body: ResponsiveWidget(
          mobile: Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      leading: Text("Name: ${widget.name}",
                          style: GoogleFonts.cinzelDecorative(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      leading: Text("email: ${widget.email}",
                          style: GoogleFonts.cinzelDecorative(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: GestureDetector(
                    onTap: () async {
                      AuthenticationService auth = AuthenticationService();
                      await auth.signOut(context);
                    },
                    child: Card(
                      color: Colors.grey[900],
                      child: ListTile(
                        leading: Text("Log out",
                            style: GoogleFonts.cinzelDecorative(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: GestureDetector(
                    onTap: () async {
                      _launchUrlStripe();
                    },
                    child: Card(
                      color: Colors.grey[900],
                      child: ListTile(
                        leading: Text("Support us",
                            style: GoogleFonts.cinzelDecorative(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                        trailing: Icon(
                          Icons.payment,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => EmailPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Card(
                      color: Colors.grey[900],
                      child: ListTile(
                        leading: Text("Contact us",
                            style: GoogleFonts.cinzelDecorative(
                                fontSize: 7.5.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl();
                  },
                  child: Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      leading: Text("Copyrights",
                          style: GoogleFonts.cinzelDecorative(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ), //////////////////////////////DESKTOP/////////////////////////////////////////////////////////////////////
          desktop: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 60.h,
                width: 35.w,
                color: Colors.grey[900],
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: ListTile(
                            leading: Text("Name: ${widget.name}",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.h),
                          child: ListTile(
                            leading: Text("email: ${widget.email}",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.h),
                          child: GestureDetector(
                            onTap: () async {
                              AuthenticationService auth =
                                  AuthenticationService();
                              await auth.signOut(context);
                            },
                            child: Card(
                              color: Colors.grey[800],
                              child: ListTile(
                                leading: Text("Log out",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 5.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => EmailPage()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Card(
                              color: Colors.grey[800],
                              child: ListTile(
                                leading: Text("Contact us",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 5.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.h),
                          child: GestureDetector(
                            onTap: () async {
                              _launchUrlStripe();
                            },
                            child: Card(
                              color: Colors.grey[800],
                              child: ListTile(
                                leading: Text("Support us",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 5.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white)),
                                trailing: Icon(
                                  Icons.payment_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl();
                          },
                          child: Card(
                            color: Colors.grey[800],
                            child: ListTile(
                              leading: Text("Copyrights",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 5.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
