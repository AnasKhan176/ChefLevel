import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/favourite_receipe_controller.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/snackbar/bottom_snackbar.dart';
import 'package:food_chef/core/utils/shared_pref_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_color.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FavouriteReceipeController _favouriteReceipeController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favouriteReceipeController = Get.put(FavouriteReceipeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
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
          SizedBox(
            width: 14.0,
            height: 14.0,
            child: Image.asset('assets/search.png'), // Use AssetImage
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              autofocus: false,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: AppColor.WHITE,
              ),
              decoration: InputDecoration.collapsed(
                hintText: "Search by chef, recipes...",
                hintStyle: TextStyle(color: AppColor.WHITE, fontSize: 12.0),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 14.0,
            height: 14.0,
            child: Image.asset('assets/filter.png'), // Use AssetImage
          ),
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
        itemCount: 4,
        itemBuilder: (context, index) {
          return _recipeCard(index);
        },
      ),
    );
  }

  Widget _recipeCard(int id) {
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
          // IMAGE WITH HEART ICON
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.asset(
                    'assets/sea_food_salad.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),

                // HEART ICON (TOP RIGHT)
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      _favouriteReceipeController.toggleFavorite(id);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Obx(
                        () => Icon(
                          _favouriteReceipeController.isFavorite(id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 14,
                          color: _favouriteReceipeController.isFavorite(id)
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // TEXT CONTENT
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
                    color: AppColor.WHITE,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Chef Tieghan Gerard',
                  style: GoogleFonts.montserrat(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: AppColor.lightgray,
                  ),
                ),
                const SizedBox(height: 4),

                // STAR + TIME ROW
                Row(
                  children: [
                    Text(
                      '⭐ 4.8 (120)',
                      style: GoogleFonts.montserrat(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightgray,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '25 min',
                      style: GoogleFonts.montserrat(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightgray,
                      ),
                    ),
                  ],
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
                  index == 0
                      ? 'Italian'
                      : index == 1
                      ? 'Japanese'
                      : index == 2
                      ? 'Mexican'
                      : index == 3
                      ? 'Vegetarian'
                      : index == 4
                      ? 'BBQ'
                      : 'Desserts',
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
                    leading: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: Image.asset(
                        'assets/your_orders.png',
                      ), // Use AssetImage
                    ),
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
                    leading: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: Image.asset(
                        'assets/save_recipes.png',
                      ), // Use AssetImage
                    ),
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
                    leading: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: Image.asset(
                        'assets/coupans.png',
                      ), // Use AssetImage
                    ),
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
                    leading: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: Image.asset(
                        'assets/earn_rewards.png',
                      ), // Use AssetImage
                    ),
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
                    leading: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: Image.asset(
                        'assets/address_book.png',
                      ), // Use AssetImage
                    ),
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
                    leading: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: Image.asset('assets/share.png'), // Use AssetImage
                    ),
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
                    leading: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: Image.asset(
                        'assets/about_us.png',
                      ), // Use AssetImage
                    ),
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
                    leading: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: Image.asset(
                        'assets/settings.png',
                      ), // Use AssetImage
                    ),
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
                    leading: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: Image.asset(
                        'assets/privacy_center.png',
                      ), // Use AssetImage
                    ),
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
  }

  Widget _createFooterItem() {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.black),
      child: ListTile(
        onTap: () async {
          // await SharedPrefService.clearOnLogout();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
            (route) => false,
          );
        },
        leading: SizedBox(
          width: 14.0,
          height: 14.0,
          child: Image.asset('assets/logout.png'), // Use AssetImage
        ),
        title: Text(
          'Logout',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: AppColor.WHITE,
          ),
        ),
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(color: Colors.transparent),
      ),
      child: SizedBox(
        height: 100.0, // Set your desired height here
        child: DrawerHeader(
          decoration: BoxDecoration(color: Colors.black),
          margin: EdgeInsets.zero,
          //padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  _key.currentState?.openEndDrawer();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColor.WHITE,
                  size: 22.0,
                ),
              ),
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
      ),
    );
  }
}
