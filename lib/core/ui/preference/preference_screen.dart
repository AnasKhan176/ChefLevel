import 'package:flutter/material.dart';
import 'package:food_chef/core/utils/app_string.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  // Expand/collapse state
  bool dietaryExpanded = true;
  bool cuisineExpanded = false;
  bool spiceExpanded = false;

  // Options
  final List<String> dietaryOptions = [
    'Veg', 'Non-Veg', 'Vegan', 'Keto', 'High-Protein',
    'Gluten-Free', 'Halal', 'Dairy-Free', 'Kosher', 'Others'
  ];
  Set<String> selectedDietary = {'Non-Veg', 'Gluten-Free'};

  final List<String> cuisines = ['Indian', 'Chinese', 'Italian', 'Mexican', 'Thai'];
  String? selectedCuisine;

  final List<String> spiceLevels = ['Mild', 'Medium', 'Hot'];
  String? selectedSpice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/common.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppString.selectYourPrefs,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Dietary Preferences Section
                  _buildExpandableSection(
                    title: AppString.dietaryPrefs,
                    expanded: dietaryExpanded,
                    onToggle: () => setState(() => dietaryExpanded = !dietaryExpanded),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: dietaryOptions.map((option) {
                        final isSelected = selectedDietary.contains(option);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedDietary.remove(option);
                              } else {
                                selectedDietary.add(option);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.red : Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Favourite Cuisines Section
                  _buildExpandableSection(
                    title: AppString.favouriteCuisines,
                    expanded: cuisineExpanded,
                    onToggle: () => setState(() => cuisineExpanded = !cuisineExpanded),
                    child: DropdownButton<String>(
                      value: selectedCuisine,
                      hint: const Text('Select Cuisine', style: TextStyle(color: Colors.white54)),
                      dropdownColor: Colors.black,
                      isExpanded: true,
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      underline: const SizedBox(),
                      items: cuisines.map((cuisine) {
                        return DropdownMenuItem(
                          value: cuisine,
                          child: Text(cuisine),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => selectedCuisine = value),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Spice Level Section
                  _buildExpandableSection(
                    title:AppString.spiceLevelPref,
                    expanded: spiceExpanded,
                    onToggle: () => setState(() => spiceExpanded = !spiceExpanded),
                    child: DropdownButton<String>(
                      value: selectedSpice,
                      hint: const Text('Select Spice Level', style: TextStyle(color: Colors.white54)),
                      dropdownColor: Colors.black,
                      isExpanded: true,
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      underline: const SizedBox(),
                      items: spiceLevels.map((level) {
                        return DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => selectedSpice = value),
                    ),
                  ),

                  const Spacer(),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Save preferences
                      },
                      child: const Text(
                        AppString.save,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool expanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with black background
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black, // Black header background
            borderRadius: BorderRadius.circular(8),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title, // use the parameter
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              IconButton(
                icon: Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white,
                ),
                onPressed: onToggle, // use the callback
              ),
            ],
          ),
        ),

        // Expandable content
        if (expanded)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: child, // use the child parameter
          ),
      ],
    );
  }
}
