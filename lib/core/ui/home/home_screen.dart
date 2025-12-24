import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColor.WHITE,),
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
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
    return const Text(
      'Find your Best Chef & Recipe\naround you',
      style: TextStyle(
        color: AppColor.WHITE,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        height: 1.3,
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
        children: const [
          Icon(Icons.search, color: AppColor.WHITE),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Search by chef, recipes...',
              style: TextStyle(color: AppColor.WHITE),
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
          style: const TextStyle(
            color: AppColor.WHITE,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          'See All',
          style: TextStyle(color: AppColor.btnBackground, fontSize: 13),
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
              children: const [
                Text(
                  'Seafood Salad',
                  style: TextStyle(color: AppColor.WHITE, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  '⭐ 4.8 (120)',
                  style: TextStyle(color: AppColor.WHITE, fontSize: 12),
                ),
              ],
            ),
          )
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
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Chef Marco\n⭐ 4.9',
                  style: TextStyle(color: AppColor.WHITE),
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
            child: const Text(
              'Cuisine',
              style: TextStyle(color: Colors.white, fontSize: 12),
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

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: const [
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: AppColor.WHITE, fontSize: 20),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: AppColor.WHITE),
            title: Text('Home', style: TextStyle(color: AppColor.WHITE)),
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: AppColor.WHITE),
            title: Text('Favorites', style: TextStyle(color: AppColor.WHITE)),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: AppColor.WHITE),
            title: Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
