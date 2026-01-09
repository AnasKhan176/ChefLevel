// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/home_recipes_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/providers/home_provider.dart';
import 'package:food_chef/core/ui/widgets/snackbar/bottom_snackbar.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SeeAllPopularTechniquesScreen extends StatefulWidget {
  const SeeAllPopularTechniquesScreen({super.key});

  @override
  State<SeeAllPopularTechniquesScreen> createState() =>
      _PopularTechniquesScreenState();
}

class _PopularTechniquesScreenState extends State<SeeAllPopularTechniquesScreen> {
  final TextEditingController searchController = TextEditingController();
  final homeRecipesController = getIt.get<HomeRecipesController>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.wait([getPopularTechniqueAllData()]);
  }

  Future<void> getPopularTechniqueAllData() async {
    HomeScreenProvider chefprovider = Provider.of<HomeScreenProvider>(
      context,
      listen: false,
    );
    final Map<String, dynamic> data = {'pageNo': '0', 'pageSize': '10'};
    var response = await homeRecipesController.getPopularTechniqueList(data);
    if (response.responseCode == 20000) {
      chefprovider.setPopularTechniqueAllData(response.data);
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
              'Popular Techniques',
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
                hintText: "Search by tags...",
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

  /// ---------------- GRID ----------------
  Widget _recipeGrid() {
    return Consumer<HomeScreenProvider>(
      builder: (_, provider, _) {
        return GridView.builder(
          itemCount: provider.popularTechniqueAllData!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            return _chefProfileCard(index, provider);
          },
        );
      },
    );
  }

  /// ---------------- CARD ----------------
  Widget _chefProfileCard(int index, HomeScreenProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(width: 1, color: AppColor.ligtestGray),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chef image inside card
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child:FadeInImage.assetNetwork(
                image: getImageUrl(
                provider.popularTechniqueAllData![index].imageResponseDTO,
                'video_thumbnail',
                'assets/images/chef_default.png',
              ),
              placeholder: 'assets/images/chef_default.png',
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 12),

          // Name and favorite icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                      provider.popularTechniqueAllData![index].chefName ?? '',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: true,
                    )
                ),
                InkWell(
                  onTap: () {
                    provider.isFavoritePopularTechniqueAll
                        ? provider.setIsFavoritePopularTechniqueAll(false)
                        : provider.setIsFavoritePopularTechniqueAll(true);
                  },
                  child: SizedBox(
                    width: 14.0,
                    height: 14.0,
                    child: Image.asset(
                      provider.isFavoritePopularTechniqueAll
                          ? 'assets/images/favorite_select.png'
                          : 'assets/images/favorite_unselect.png',
                    ), // Use AssetImage
                  ),
                ),
              ],
            ),
          ),

          // Top-Rated label
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              provider.popularTechniqueAllData![index].title ?? '',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),

          // const Spacer(),
          // Rating and recipe count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 12),
                    SizedBox(width: 4),
                    Text(
                      '4.0 (1206).',
                      style: TextStyle(fontSize: 10, color: Colors.white54),
                    ),
                  ],
                ),
                const Text(
                  '40 Recipes.',
                  style: TextStyle(fontSize: 10, color: Colors.white54),
                ),
              ],
            ),
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
