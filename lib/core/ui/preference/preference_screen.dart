import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/user_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/domain/models/pref_data_model.dart';
import 'package:food_chef/core/ui/home/home.dart';
import 'package:food_chef/core/utils/app_string.dart';
import 'package:food_chef/core/utils/shared_pref_service.dart';
import 'package:food_chef/core/utils/snackbar.dart';
import 'package:food_chef/theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

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
    'Veg',
    'Non-Veg',
    'Vegan',
    'Keto',
    'High-Protein',
    'Gluten-Free',
    'Halal',
    'Dairy-Free',
    'Kosher',
    'Others',
  ];
  Set<String> selectedDietary = {'Non-Veg', 'Gluten-Free'};

  final List<String> cuisines = [
    'Indian',
    'Chinese',
    'Italian',
    'Mexican',
    'Thai',
  ];
  Set<String> selectedCuisine = {'Indian', 'Chinese'};

  final List<String> spiceLevels = ['Mild', 'Medium', 'Hot'];
  String? selectedSpice;

  String _selectedSpice = 'Mild';
  final userController = getIt.get<UserController>(); 

  // Api Data
  List<Data> ? spice_data_list;
  List<Data> ? favorite_data_list;
  List<Data> ? dietary_data_list;


   @override
  void initState() {
    super.initState();
    
    getData();
  }

  Future<void>  getData() async{
   await Future.wait([

    getSpice('SPICE_LEVEL'),
    getFavourite('FAVOURITE_CUISINE'),
    getDietary('DIETARY_PREFERENCE'),
    
   ]);
}


  Future<void>  getSpice(String test) async{

      // Usage example:
final Map<String, dynamic> data = {
  'check': test  
};
var api_response= await userController.dataDefination(data);


if(api_response?.responseCode==20000)
{
spice_data_list=api_response?.data;
print(spice_data_list!.length.toString());

 }
else{
    CustomSnackBar.showTopSnackbar(context,api_response?.message,AppColor.btnBackground);
}
  }
  

  Future<void>  getFavourite(String test) async{

      // Usage example:
final Map<String, dynamic> data = {
  'check': test  
};
var api_response= await userController.dataDefination(data);


if(api_response?.responseCode==20000)
{
favorite_data_list=api_response?.data;
print(favorite_data_list!.length.toString());

 }
else{
    CustomSnackBar.showTopSnackbar(context,api_response?.message,AppColor.btnBackground);
}
  }
  Future<void>  getDietary(String test) async{

      // Usage example:
final Map<String, dynamic> data = {
  'check': test  
};
var api_response= await userController.dataDefination(data);


if(api_response?.responseCode==20000)
{
dietary_data_list=api_response?.data;
print(dietary_data_list!.length.toString());

 }
else{
    CustomSnackBar.showTopSnackbar(context,api_response?.message,AppColor.btnBackground);
}
  }
  
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.selectYourPrefs,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: AppColor.WHITE,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Dietary Preferences Section
                    _buildExpandableSection(
                      title: AppString.dietaryPrefs,
                      expanded: dietaryExpanded,
                      onToggle: () =>
                          setState(() => dietaryExpanded = !dietaryExpanded),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.btnBackground
                                    : Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                option,
                                style: GoogleFonts.montserrat(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  color:isSelected? AppColor.WHITE:AppColor.WHITE) 
                                ,
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
                      onToggle: () =>
                          setState(() => cuisineExpanded = !cuisineExpanded),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: cuisines.map((option) {
                          final isSelected = selectedCuisine.contains(option);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedCuisine.remove(option);
                                } else {
                                  selectedCuisine.add(option);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.btnBackground
                                    : Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                option,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
                                    color: isSelected
                                      ? AppColor.WHITE
                                      : AppColor.WHITE,
                                  )
                                
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Spice Level Section
                    _buildExpandableSection(
                      title: AppString.spiceLevelPref,
                      expanded: spiceExpanded,
                      onToggle: () =>
                          setState(() => spiceExpanded = !spiceExpanded),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRadio('Mild'),
                          _buildRadio('Medium'),
                          _buildRadio('Spicy'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.btnBackground,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          // first check user select all the fields then save
                        await SharedPrefService.setPrefLevel(true);
                        Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(builder: (_) => HomeScreen())
                               );

                        },
                        child: Text(
                          AppString.save,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: AppColor.WHITE,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                style: GoogleFonts.playfairDisplay(
                                    fontSize: 16,
  fontWeight: FontWeight.w600,
  fontStyle: FontStyle.normal,
                                    color: AppColor.WHITE,
                                  ),
              ),
              IconButton(
                icon: Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColor.WHITE,
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

  Widget _buildRadio(String value) {
    return RadioListTile<String>(
      contentPadding: EdgeInsets.zero,
      title: Text(value, style: GoogleFonts.montserrat(
                                    fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
                                    color: AppColor.WHITE,
                                  )),
      value: value,
      groupValue: _selectedSpice,
      activeColor: AppColor.btnBackground,
      onChanged: (val) {
        setState(() {
          _selectedSpice = val!;
        });
      },
    );
  }
}