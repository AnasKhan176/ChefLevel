import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeHomeScreen extends StatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  State<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<RecipeHomeScreen> {
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
              const SizedBox(height: 16),
              _categoryChips(),
              const SizedBox(height: 20),
              Expanded(child: _recipeGrid()),
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
          'Tailored Recipes for You',
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
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white54),
        ),
        onTap: () {
          // Keyboard opens automatically
        },
      ),
    );
  }

  /// ---------------- CATEGORY CHIPS ----------------
  Widget _categoryChips() {
    final categories = [
      'All',
      'Latest',
      'Under 30 Min',
      'High Flame',
      'Italian',
      'Low Fat',
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
    return GridView.builder(
      itemCount: favorites.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return _recipeCard(index);
      },
    );
  }

  /// ---------------- CARD ----------------
  Widget _recipeCard(int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
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
          ),
          const SizedBox(height: 8),
          Center(
            child: CircleAvatar(
              radius: 44,
              backgroundImage:
              const AssetImage('assets/vegeterian.png'),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            index.isOdd ? 'Spicy noodles' : 'Seafood salad',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Chef Marco Italian',
            style: GoogleFonts.montserrat(
              fontSize: 11,
              color: Colors.white54,
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
                    '4.0 (1209)',
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
              Text(
                '35 min',
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
}