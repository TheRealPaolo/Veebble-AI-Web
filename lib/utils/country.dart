import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:veebble_web/utils/responsive.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> countries = [
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

    Widget buildCountryText(String country) {
      return Text(
        country,
        style: MediaQuery.of(context).size.width < 340 ||
                MediaQuery.of(context).size.width < 930
            ? GoogleFonts.oswald(color: Colors.white, fontSize: 10.sp)
            : GoogleFonts.oswald(color: Colors.white, fontSize: 4.sp),
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: ResponsiveWidget(
          mobile: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  AppBar(
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
                  SizedBox(height: 2.h),
                  const Text(
                    "Countries and territories officially supported at the moment",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Text(
                      "However no geographic restrictions, let a way to use with VPNs",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 2.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: buildCountryText(countries[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ////////////////////////////////////////////////////DESKTOP////////////////////////////////////////////////////
          desktop: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 2.h),
                const Text(
                  "Countries and territories officially supported at the moment",
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                    "However no geographic restrictions, let a way to use with VPNs",
                    style: TextStyle(color: Colors.white)),
                Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 7,
                      crossAxisCount: 4,
                    ),
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildCountryText(countries[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
