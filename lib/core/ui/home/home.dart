import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColor.WHITE),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/common.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            const SizedBox(height: 16),
            _searchBar(),
            const SizedBox(height: 24),
            _sectionTitle('Tailored Recipes for You'),
            const SizedBox(height: 12),
            _recipeHorizontalList(),
            const SizedBox(height: 24),
            _sectionTitle('Master Chefs'),
            const SizedBox(height: 12),
            _chefHorizontalList(),
            const SizedBox(height: 24),
            _sectionTitle('Popular Cuisine'),
            const SizedBox(height: 12),
            _cuisineGrid(),
            const SizedBox(height: 24),
            _sectionTitle('Popular Techniques'),
            const SizedBox(height: 12),
            _techniqueHorizontalList(),
          ],
        ),
      ),
    );
  }

  // ---------------- WIDGETS ----------------

  Widget _headerText() {
    return Text(
      'Find your Best Chef & Recipe\naround you',
      style: GoogleFonts.playfairDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColor.WHITE,
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColor.WHITE),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              autofocus: false,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: AppColor.WHITE,
              ),
              decoration: InputDecoration.collapsed(
                hintText: "Search by chef, recipes...",
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.tune, color: AppColor.WHITE),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: AppColor.WHITE,
          ),
        ),
        Text(
          'See All',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: AppColor.btnBackground,
          ),
        ),
      ],
    );
  }

  Widget _recipeHorizontalList() {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return _recipeCard();
        },
      ),
    );
  }

  Widget _recipeCard() {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/sea_food_salad.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seafood Salad',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: AppColor.WHITE,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Chef Tieghan Gerard',
                  style: GoogleFonts.montserrat(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: AppColor.lightgray,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '⭐ 4.8 (120)',
                  style: GoogleFonts.montserrat(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: AppColor.lightgray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chefHorizontalList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            width: 220,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/safe_marco.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Chef Marco',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: AppColor.WHITE,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '⭐ 4.9',
                        style: GoogleFonts.montserrat(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: AppColor.lightgray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _cuisineGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: List.generate(
        6,
        (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: const DecorationImage(
              image: AssetImage('assets/italian.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.black.withOpacity(0.4),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Cuisine',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: AppColor.WHITE,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _techniqueHorizontalList() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            width: 240,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/wth_3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.play_circle_fill,
                color: AppColor.WHITE,
                size: 50,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        // Changed this to a Column from a ListView
        children: <Widget>[
          _createHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Your Information',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: AppColor.WHITE,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home, color: AppColor.WHITE),
                    title: Text(
                      'Your Orders',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite, color: AppColor.WHITE),
                    title: Text(
                      'Save Recipes',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.emoji_emotions, color: AppColor.WHITE),
                    title: Text(
                      'Coupons',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.money, color: AppColor.WHITE),
                    title: Text(
                      'Earn & Redeem',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email, color: AppColor.WHITE),
                    title: Text(
                      'Address Book',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Others',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: AppColor.WHITE,
                        ),
                      ),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.logout, color: AppColor.WHITE),
                    title: Text(
                      'Share App',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.abc, color: AppColor.WHITE),
                    title: Text(
                      'About Us',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: AppColor.WHITE),
                    title: Text(
                      'Settings',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip, color: AppColor.WHITE),
                    title: Text(
                      'Privacy Center',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _createFooterItem(),
        ],
      ),
    );

    // //         ),
    // Container(
    //       height: 60, // Set your desired height
    //       decoration: BoxDecoration(
    //         color: Colors.transparent, // Optional: set a background color
    //         // No default border here
    //       ),
    //       child: Center(
    //                    child: Text(
    //             'Chef Level',
    //             style:  GoogleFonts.playfairDisplay(
    // fontSize: 14,
    // fontWeight: FontWeight.w600,
    // fontStyle: FontStyle.normal,
    // color: AppColor.btnBackground,
    // ),
    //       ),
    //     ),),
  }

  Widget _createFooterItem() {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.black),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.logout, color: AppColor.WHITE),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Logout',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: AppColor.WHITE,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return
    Theme(
data: Theme.of(context).copyWith(
dividerTheme: const DividerThemeData(color: Colors.transparent),
),
child:
     SizedBox(
      height: 60.0, // Set your desired height here
      child: DrawerHeader(
        decoration: BoxDecoration(color: Colors.black,),
        margin: EdgeInsets.zero,
        //padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(Icons.arrow_back, color: AppColor.WHITE),
            SizedBox(width: 50.0),
            Text(
              'Chef Level',
              style: GoogleFonts.playfairDisplay(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: AppColor.btnBackground,
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
