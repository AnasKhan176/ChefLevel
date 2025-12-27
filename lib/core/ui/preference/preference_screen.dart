// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/user_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/domain/models/pref_data_model.dart';
import 'package:food_chef/core/ui/home/home.dart';
import 'package:food_chef/core/ui/snackbar/app_loader.dart';
import 'package:food_chef/core/utils/app_string.dart';
import 'package:food_chef/core/utils/shared_pref_service.dart';
import 'package:food_chef/core/utils/snackbar.dart';
import 'package:food_chef/theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

import '../snackbar/bottom_snackbar.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  // Expand/collapse state
  bool dietaryExpanded = false;
  bool cuisineExpanded = false;
  bool spiceExpanded = false;

  //radio group value
  int _selectedVal = 0;
  String? _selectedSpice = '';
  final userController = getIt.get<UserController>();

  // Api Data
  List<Data>? spice_data_list;
  List<Data>? favorite_data_list;
  List<Data>? dietary_data_list;

  final List<Data> _filters_spice = <Data>[];
  final List<Data> _filters_favorite = <Data>[];
  final List<Data> _filters_dietary = <Data>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.wait([
      fetchSpiceApi('SPICE_LEVEL'),
      fetchFavouriteApi('FAVOURITE_CUISINE'),
      fetchDietaryApi('DIETARY_PREFERENCE'),
    ]);
  }

  Future<List<Data>> fetchSpiceApi(String test) async {
    // Usage example:
    // AppLoader.show(context);
    final Map<String, dynamic> data = {'check': test};
    var api_response = await userController.dataDefination(data);

    if (api_response?.responseCode == 20000) {
      //  AppLoader.hide();
      spice_data_list = api_response?.data;
      print(spice_data_list!.length.toString());
    } else {
      // AppLoader.hide();
      BottomSnackBar.show(
        context,
        message: api_response!.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
    return spice_data_list ?? [];
  }

  Future<List<Data>> fetchFavouriteApi(String test) async {
    // Usage example:
    final Map<String, dynamic> data = {'check': test};
    var api_response = await userController.dataDefination(data);
    // AppLoader.show(context);

    if (api_response?.responseCode == 20000) {
      // AppLoader.hide();
      favorite_data_list = api_response?.data;
    } else {
      //  AppLoader.hide();
      BottomSnackBar.show(
        context,
        message: api_response!.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
    return favorite_data_list ?? [];
  }

  Future<List<Data>> fetchDietaryApi(String test) async {
    // Usage example:
    final Map<String, dynamic> data = {'check': test};
    var api_response = await userController.dataDefination(data);
    // AppLoader.show(context);

    if (api_response?.responseCode == 20000) {
      // AppLoader.hide();
      dietary_data_list = api_response?.data;
      print(dietary_data_list!.length.toString());
    } else {
      // AppLoader.hide();

      BottomSnackBar.show(
        context,
        message: api_response!.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
    return dietary_data_list ?? [];
  }

  Future<List<Data>> getSpice() async {
    return spice_data_list ?? [];
  }

  Future<List<Data>> getFavorite() async {
    return favorite_data_list ?? [];
  }

  Future<List<Data>> getDietary() async {
    return dietary_data_list ?? [];
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

                    //  Dietary Preferences Section
                    _buildExpandableSection(
                      title: AppString.dietaryPrefs,
                      expanded: dietaryExpanded,
                      onToggle: () =>
                          setState(() => dietaryExpanded = !dietaryExpanded),
                      child: Column(
                        children: <Widget>[
                          FutureBuilder<List<Data>>(
                            future: getDietary(),
                            builder:
                                (
                                  BuildContext context,
                                  AsyncSnapshot<List<Data>> snapshot,
                                ) {
                                  Widget result;
                                  if (snapshot.hasData) {
                                    result = Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: snapshot.data!.map((
                                        Data option,
                                      ) {
                                        final isSelected = _filters_dietary
                                            .contains(option);
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                _filters_dietary.remove(option);
                                              } else {
                                                _filters_dietary.add(option);
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
                                                  : Colors.black.withOpacity(
                                                      0.6,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              option.value ?? '',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color: isSelected
                                                    ? AppColor.WHITE
                                                    : AppColor.WHITE,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  } else if (snapshot.hasError) {
                                    result = Text('Error: ${snapshot.error}');
                                  } else {
                                    result = const Text('Awaiting result...');
                                  }
                                  return result;
                                },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Favourite Cuisines Section
                    _buildExpandableSection(
                      title: AppString.favouriteCuisines,
                      expanded: cuisineExpanded,
                      onToggle: () =>
                          setState(() => cuisineExpanded = !cuisineExpanded),
                      child: Column(
                        children: <Widget>[
                          FutureBuilder<List<Data>>(
                            future: getFavorite(),
                            builder:
                                (
                                  BuildContext context,
                                  AsyncSnapshot<List<Data>> snapshot,
                                ) {
                                  Widget result;
                                  if (snapshot.hasData) {
                                    result = Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: snapshot.data!.map((
                                        Data option,
                                      ) {
                                        final isSelected = _filters_favorite
                                            .contains(option);
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                _filters_favorite.remove(
                                                  option,
                                                );
                                              } else {
                                                _filters_favorite.add(option);
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
                                                  : Colors.black.withOpacity(
                                                      0.6,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              option.value ?? '',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color: isSelected
                                                    ? AppColor.WHITE
                                                    : AppColor.WHITE,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  } else if (snapshot.hasError) {
                                    result = Text('Error: ${snapshot.error}');
                                  } else {
                                    result = const Text('Awaiting result...');
                                  }
                                  return result;
                                },
                          ),
                        ],
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
                        children: <Widget>[
                          FutureBuilder<List<Data>>(
                            future: getSpice(),
                            builder:
                                (
                                  BuildContext context,
                                  AsyncSnapshot<List<Data>> snapshot,
                                ) {
                                  Widget result;
                                  if (snapshot.hasData) {
                                    result = Wrap(
                                      spacing: 2,
                                      runSpacing: 2,
                                      children: snapshot.data!.map((
                                        Data option,
                                      ) {
                                        return _buildRadio(option);
                                      }).toList(),
                                    );
                                  } else if (snapshot.hasError) {
                                    result = Text('Error: ${snapshot.error}');
                                  } else {
                                    result = const Text('Awaiting result...');
                                  }
                                  return result;
                                },
                          ),
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

                          print(_filters_favorite.toString());
                          print(_filters_dietary.toString());
                          print(_selectedSpice);

                          if (_filters_dietary.isNotEmpty &&
                              _filters_favorite.isNotEmpty &&
                              _selectedSpice!.isNotEmpty) {
                            await SharedPrefService.setPrefLevel(true);
                            BottomSnackBar.show(
                              context,
                              message: 'Preference saved.!!',
                              backgroundColor: Colors.green,
                              icon: Icons.check_circle,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => HomeScreen()),
                            );
                          } else {
                            BottomSnackBar.show(
                              context,
                              message: 'Please select preferences.!!',
                              backgroundColor: AppColor.btnBackground,
                              icon: Icons.error,
                            );
                          }
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

  Widget _buildRadio(Data data) {
    return RadioListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        data.value ?? '',
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: AppColor.WHITE,
        ),
      ),
      value: data.id,
      // ignore: deprecated_member_use
      groupValue: _selectedVal,
      activeColor: AppColor.btnBackground,
      onChanged: (val) {
        setState(() {
          _selectedVal = data.id!;
          _selectedSpice = data.value;
        });
      },
    );
  }
}
