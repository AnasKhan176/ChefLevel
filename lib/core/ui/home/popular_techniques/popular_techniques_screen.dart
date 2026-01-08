import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularTechniquesScreen extends StatefulWidget {
  const PopularTechniquesScreen({super.key});

  @override
  State<PopularTechniquesScreen> createState() => _PopularTechniquesScreenState();
}

class _PopularTechniquesScreenState extends State<PopularTechniquesScreen> {
  final List<bool> favorites = List.generate(6, (_) => false);
  int selectedChipIndex = 0;
  final TextEditingController searchController = TextEditingController();

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
              // const SizedBox(height: 16),
              // _categoryChips(),
              const SizedBox(height: 20),
              Expanded(child: _recipeGrid()),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF6A6A),
                        Color(0xFFE53935),
                      ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(24),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        Text(
          'Popular Techniques',
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        InkWell(
          onTap: () {
            debugPrint('Filter clicked');
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  /// ---------------- SEARCH BAR ----------------
  Widget _searchBar() {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: searchController,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.white54),
          hintText: 'Search by techs',
          hintStyle: TextStyle(color: Colors.white54),
        ),
        onTap: () {
          // Keyboard opens automatically
        },
      ),
    );
  }

  /// ---------------- CATEGORY CHIPS ----------------
  // Widget _categoryChips() {
  //   final categories = [
  //     'All',
  //     'Latest',
  //     'Under 30 Min',
  //     'High Flame',
  //     'Italian',
  //     'Low Fat',
  //   ];
  //
  //   return SizedBox(
  //     height: 36,
  //     child: ListView.separated(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: categories.length,
  //       separatorBuilder: (_, __) => const SizedBox(width: 8),
  //       itemBuilder: (context, index) {
  //         final bool isSelected = selectedChipIndex == index;
  //
  //         return InkWell(
  //           onTap: () {
  //             setState(() {
  //               selectedChipIndex = index;
  //             });
  //           },
  //           borderRadius: BorderRadius.circular(20),
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 14),
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //               color: isSelected ? Colors.red : const Color(0xFF1C1C1C),
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Text(
  //               categories[index],
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w500,
  //                 color: isSelected ? Colors.white : Colors.white70,
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  /// ---------------- GRID ----------------
  Widget _recipeGrid() {
    return GridView.builder(
      itemCount: favorites.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return _chefProfileCard(index);
      },
    );
  }

  /// ---------------- CARD ----------------
  Widget _chefProfileCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chef image inside card
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.asset(
              'assets/wth_3.jpg',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),

          // Name and favorite icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Knife Skills',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      favorites[index] = !favorites[index];
                    });
                  },
                  child: Icon(
                    favorites[index]
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favorites[index] ? Colors.red : Colors.white54,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),

          // Top-Rated label
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              'Top-Rated',
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
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 4),
                    Text(
                      '4.0 (1206)',
                      style: TextStyle(fontSize: 11, color: Colors.white54),
                    ),
                  ],
                ),
                const Text(
                  '40 Recipes',
                  style: TextStyle(fontSize: 11, color: Colors.white54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}