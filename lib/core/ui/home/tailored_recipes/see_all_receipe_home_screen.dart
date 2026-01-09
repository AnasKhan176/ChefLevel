// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/home_recipes_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/providers/home_provider.dart';
import 'package:food_chef/core/ui/widgets/snackbar/bottom_snackbar.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SeeAllTailoredRecipeHomeScreen extends StatefulWidget {
  const SeeAllTailoredRecipeHomeScreen({super.key});

  @override
  State<SeeAllTailoredRecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<SeeAllTailoredRecipeHomeScreen> {
  int selectedChipIndex = 0;
  final TextEditingController searchController = TextEditingController();
  final homeRecipesController = getIt.get<HomeRecipesController>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.wait([getTailoredRecipesData()]);
  }

  Future<void> getTailoredRecipesData() async {
    HomeScreenProvider tailoredprovider = Provider.of<HomeScreenProvider>(
      context,
      listen: false,
    );
    final Map<String, dynamic> data = {'pageNo': '0', 'pageSize': '10'};
    var response = await homeRecipesController.getTailoerdRecipeList(data);
    if (response.responseCode == 20000) {
      tailoredprovider.setTailoredAllRecipiesData(response.data);
    } else {
      BottomSnackBar.show(
        context,
        message: response.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBar(context),
              const SizedBox(height: 16),
              _searchBar(),
              const SizedBox(height: 16),
              _categoryChips(),
              const SizedBox(height: 20),
              Expanded(child: _recipeGrid()),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6A6A), Color(0xFFE53935)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        // Load more action
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Load More',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- TOP BAR ----------------
  Widget _topBar(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(24),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tailored Recipes for You',
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ---------------- SEARCH BAR ----------------
  Widget _searchBar() {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColor.ligtestGray),
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: false,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: AppColor.white,
              ),
              decoration: InputDecoration.collapsed(
                hintText: "Search by recipe name...",
                hintStyle: TextStyle(color: AppColor.white, fontSize: 12.0),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 14.0,
            height: 14.0,
            child: Image.asset('assets/search.png'), // Use AssetImage
          ),
        ],
      ),
    );
  }

  /// ---------------- CATEGORY CHIPS ----------------
  Widget _categoryChips() {
    final categories = [
      'Italian',
      'Japanese',
      'Mexican',
      'BBQ',
      'Vegetarian',
      'Desserts',
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final bool isSelected = selectedChipIndex == index;

          return InkWell(
            onTap: () {
              setState(() {
                selectedChipIndex = index;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.red : const Color(0xFF1C1C1C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.white70,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ---------------- GRID ----------------
  Widget _recipeGrid() {
    return Consumer<HomeScreenProvider>(
      builder: (_, provider, _) {
        return GridView.builder(
          itemCount: provider.tailoredRecipiesAllData!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            return _recipeCard(index, provider);
          },
        );
      },
    );
  }

  /// ---------------- CARD ----------------
  Widget _recipeCard(int index, HomeScreenProvider provider) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColor.ligtestGray),
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                provider.isFavoriteTailoredAll
                    ? provider.setIsFavoriteTailoredAll(false)
                    : provider.setIsFavoriteTailoredAll(true);
              },
              child: SizedBox(
                width: 14.0,
                height: 14.0,
                child: Image.asset(
                  provider.isFavoriteTailoredAll
                      ? 'assets/images/favorite_select.png'
                      : 'assets/images/favorite_unselect.png',
                ), // Use AssetImage
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: AppColor.ligtestGray),
              ),
              child: CircleAvatar(
                radius: 44,
                backgroundImage: 
                NetworkImage(
                  getImageUrl(
                    provider.tailoredRecipiesAllData![index].image,
                    'recipe',
                    'assets/images/cuisine_default.png',
                  ),
                ),

                
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              provider.tailoredRecipiesAllData![index].dishName ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              provider.tailoredRecipiesAllData![index].chefName ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 11,
                color: Colors.white54,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '4.0 (1209).',
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
              Text(
                '${provider.tailoredRecipiesAllData![index].prepTime} min',
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //---------------- Methods ---------------

  String getImageUrl(
    List<dynamic>? image_list,
    String file_type,
    String default_image,
  ) {
    int index = image_list!.indexWhere(
      (image_url) => image_url.fileType!.toLowerCase() == file_type,
    );
    if (index != -1) {
      return image_list[index].filePath ?? default_image;
    }
    return default_image;
  }
}
