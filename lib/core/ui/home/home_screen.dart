// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/home_recipes_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/domain/models/home/home_recipes_model.dart';
import 'package:food_chef/core/providers/home_provider.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/widgets/snackbar/bottom_snackbar.dart';
import 'package:food_chef/core/ui/home/food_banner.dart';
import 'package:food_chef/core/ui/home/master_chefs/master_chef_screen.dart';
import 'package:food_chef/core/ui/home/popular_techniques/popular_techniques_screen.dart';
import 'package:food_chef/core/ui/home/tailored_recipes/receipe_home_screen.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:food_chef/core/utils/constant/fonts/font_style.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeRecipesController = getIt.get<HomeRecipesController>();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.wait([getHomeRecipesData()]);
  }

  Future<void> getHomeRecipesData() async {
    HomeScreenProvider homeProvider = Provider.of<HomeScreenProvider>(
      context,
      listen: false,
    );
    final Map<String, dynamic> data = {'pageNo': '0', 'pageSize': '6'};
    var response = await homeRecipesController.getHomeData(data);
    if (response.responseCode == 20000) {
      homeProvider.setHomeRecipesData(response.data);
    } else {
      BottomSnackBar.show(
        context,
        message: response!.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
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
            icon: const Icon(Icons.menu, color: AppColor.white),
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
            // const SizedBox(height: 16),
            // _searchBar(),
            const SizedBox(height: 24),
            FoodBanner(),
            const SizedBox(height: 24),
            _sectionTitle(
              title: 'Tailored Recipes for You',
              onSeeAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RecipeHomeScreen()),
                );
              },
            ),
            const SizedBox(height: 12),
            _recipeHorizontalList(),
            const SizedBox(height: 12),
            _sectionTitle(title: 'Master Chefs', onSeeAllTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MasterChefScreen())
              );
            }),
            const SizedBox(height: 12),
            _chefHorizontalList(),
            const SizedBox(height: 12),
            _sectionTitle(title: 'Popular Cuisine', onSeeAllTap: (){}),
            const SizedBox(height: 12),
            _cuisineGrid(),
            // const SizedBox(height: 12),
            _sectionTitle(title: 'Popular Techniques', onSeeAllTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PopularTechniquesScreen())
              );
            }),
            const SizedBox(height: 12),
            _techniqueHorizontalList(),
            const SizedBox(height: 50),
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
        color: AppColor.white,
      ),
    );
  }

  // Widget _searchBar() {
  //   return Container(
  //     height: 50,
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     decoration: BoxDecoration(
  //       border: Border.all(width: 1, color: AppColor.ligtestGray),
  //       color: Colors.white.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Row(
  //       children: [
  //         SizedBox(
  //           width: 14.0,
  //           height: 14.0,
  //           child: Image.asset('assets/search.png'), // Use AssetImage
  //         ),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: TextField(
  //             autofocus: false,
  //             style: GoogleFonts.montserrat(
  //               fontSize: 12,
  //               fontWeight: FontWeight.w400,
  //               fontStyle: FontStyle.normal,
  //               color: AppColor.white,
  //             ),
  //             decoration: InputDecoration.collapsed(
  //               hintText: "Search by chef, recipes...",
  //               hintStyle: TextStyle(color: AppColor.white, fontSize: 12.0),
  //               border: InputBorder.none,
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           width: 14.0,
  //           height: 14.0,
  //           child: Image.asset('assets/filter.png'), // Use AssetImage
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _sectionTitle({required String title, VoidCallback? onSeeAllTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppFontStyle.whiteText14Bold),
        InkWell(
          onTap: onSeeAllTap,
          child: Text('See All', style: AppFontStyle.redText12NormalMont),
        ),
      ],
    );
  }

  Widget _recipeHorizontalList() {
    return Consumer<HomeScreenProvider>(
      builder: (_, provider, _) {
        return SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.tailoredRecipesData!.length,
            itemBuilder: (context, index) {
              return _recipeCard(index, provider);
            },
          ),
        );
      },
    );
  }
}

Widget _recipeCard(int index, HomeScreenProvider provider) {
  return Container(
    width: 160,
    margin: const EdgeInsets.only(right: 16),
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: AppColor.ligtestGray),

      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
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
                  top: Radius.circular(8),
                ),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/recipe_default.png'),
                  image: NetworkImage(
                    getImageUrl(provider.tailoredRecipesData![index].image,'recipe','assets/images/recipe_default.png'),
                  ),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // HEART ICON (TOP RIGHT)
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 14,
                      color:
                          Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                provider.tailoredRecipesData![index].dishName ?? '',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                provider.tailoredRecipesData![index].chefName ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  color: AppColor.lightgray,
                ),
              ),
              const SizedBox(height: 4),

              // STAR + TIME ROW
              Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    Text(
                      '⭐ 4.8 (120).',
                      style: GoogleFonts.montserrat(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightgray,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${provider.tailoredRecipesData![index].prepTime} min',
                      style: GoogleFonts.montserrat(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightgray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

 //---------------- Methods ---------------

String getImageUrl(List<dynamic>? image_list, String file_type, String default_image) {
  int index = image_list!.indexWhere(
    (image_url) => image_url.fileType!.toLowerCase() == file_type,
  );
  if (index != -1) {
    return image_list[index].filePath ?? default_image;
  }
  return default_image;
}


Widget _chefHorizontalList() {

  return Consumer<HomeScreenProvider>(
      builder: (_, provider, _) {
        return  SizedBox(
    height: 150,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: provider.masterChefData!.length,
      itemBuilder: (context, index) {
        return Container(
          width: 220,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColor.ligtestGray),                    
            borderRadius: BorderRadius.circular(8),
            image:  DecorationImage(
              image: NetworkImage(getImageUrl(provider.masterChefData![index].imageResponse,'chef_profile_photo','assets/images/chef_default.png')),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ),
            ),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.masterChefData![index].name ?? '',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: AppColor.white,
                        ),
                      ),
                      Text(
                        '⭐ 4.9.',
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
                Spacer(),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Top-Rated.',
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColor.lightgray,
                        ),
                      ),
                      Text(
                        '${provider.masterChefData![index].recipeCount} Recipies',
                       style: GoogleFonts.montserrat(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: AppColor.lightgray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );});
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
            border: Border.all(width: 1, color: AppColor.ligtestGray),

            borderRadius: BorderRadius.circular(8),
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
                  color: AppColor.white,
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
  return Consumer<HomeScreenProvider>(
      builder: (_, provider, _) {
        return SizedBox(
    height: 160,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: provider.popularTechniquesData!.length,
      itemBuilder: (context, index) {
        return Container(
          width: 240,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColor.ligtestGray),
            borderRadius: BorderRadius.circular(8),
            image:  DecorationImage(
              image:NetworkImage(getImageUrl(provider.popularTechniquesData![index].imageResponseDTO,'video_thumbnail','assets/images/popular_technique_default.png'),
) ,
              fit: BoxFit.cover,
            ),
          ),

          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 28.0,
                      height: 28.0,
                      child: Image.asset('assets/play.png'), // Use AssetImage
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                            provider.popularTechniquesData![index].chefName??'',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: AppColor.white,
                                ),
                              ),
                              Text(
                                provider.popularTechniquesData![index].title??'',
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
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '35 Min.',
                                style: GoogleFonts.montserrat(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.lightgray,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Center(
            //   child: SizedBox(
            //           width: 24.0,
            //           height: 24.0,
            //           child: Image.asset(
            //             'assets/play.png',
            //           ), // Use AssetImage
            //         ),
            // ),
            // Row(
            //     children: [
            //       Align(
            //         alignment: Alignment.bottomLeft,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               index==0?'Master Class: Knife Skills':index==1?'Master Class: BBQ':'Master Class: Barbie',
            //               style: GoogleFonts.playfairDisplay(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w600,
            //                 fontStyle: FontStyle.normal,
            //                 color: AppColor.white,
            //               ),
            //             ),
            //             Text(
            //               'Chef marco',
            //               style: GoogleFonts.montserrat(
            //                 fontSize: 8,
            //                 fontWeight: FontWeight.w400,
            //                 fontStyle: FontStyle.normal,
            //                 color: AppColor.lightgray,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Spacer(),
            //       Align(
            //         alignment: Alignment.bottomRight,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Text(
            //               '35 Min',
            //               style: GoogleFonts.montserrat(
            //                 fontSize: 8,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColor.lightgray,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
          ),
        );
      },
    ),
  );},);
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
                        color: AppColor.white,
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
                      color: AppColor.white,
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
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 14.0,
                    height: 14.0,
                    child: Image.asset('assets/coupans.png'), // Use AssetImage
                  ),
                  title: Text(
                    'Coupons',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
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
                      color: AppColor.white,
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
                      color: AppColor.white,
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
                        color: AppColor.white,
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
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 14.0,
                    height: 14.0,
                    child: Image.asset('assets/about_us.png'), // Use AssetImage
                  ),
                  title: Text(
                    'About Us',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 14.0,
                    height: 14.0,
                    child: Image.asset('assets/settings.png'), // Use AssetImage
                  ),
                  title: Text(
                    'Settings',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
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
                      color: AppColor.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _createFooterItem(context),
      ],
    ),
  );
}

Widget _createFooterItem(BuildContext context) {
  return DecoratedBox(
    decoration: BoxDecoration(color: Colors.black),
    child: ListTile(
      onTap: () async {
        await SharedPrefService.clearOnLogout();
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
          color: AppColor.white,
        ),
      ),
    ),
  );
}

Widget _createHeader(BuildContext context) {
  return Theme(
    data: Theme.of(
      context,
    ).copyWith(dividerTheme: const DividerThemeData(color: Colors.transparent)),
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
                //_key.currentState?.openEndDrawer();
              },
              child: Icon(Icons.arrow_back, color: AppColor.white, size: 22.0),
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
