import 'package:flutter/material.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../theme/app_color.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/wth_1.jpg",
      "title": "Build your \n flavour step by step",
      "subtitle": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nunc sit amet finibus leo, id mattis urna",
    },
    {
      "image": "assets/wth_2.jpg",
      "title": "Cook like a pro with \n chef-approved recipes",
      "subtitle": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nunc sit amet finibus leo, id mattis urna",
    },
    {
      "image": "assets/wth_3.jpg",
      "title": "We’ll tailor recipes \n just the way you like",
      "subtitle": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nunc sit amet finibus leo, id mattis urna",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() => currentPage = index);
            },
            itemBuilder: (_, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(pages[index]["image"]!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Skip button
                    Positioned(
                      top: 40,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.WHITE,
                          ),
                        ),
                      ),
                    ),

                    // Texts and dots + button
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              pages[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColor.WHITE,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              pages[index]["subtitle"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.WHITE,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Dots indicator
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: pages.length,
                              effect: const WormEffect(
                                activeDotColor: AppColor.btnBackground,
                                dotColor: AppColor.WHITE,
                                dotHeight: 10,
                                dotWidth: 10,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // // Next button (hide on last page if you want)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (currentPage == pages.length - 1) {
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const LoginScreen())
                                    );
                                  } else{
                                      _pageController.nextPage(
                                        duration: const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.btnBackground,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                  ),
                                  child: Text(
                                    currentPage == pages.length - 1 ? "Get Started" : "Next",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.WHITE,
                                    ),
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
            },
          ),
        ],
      ),
    );
  }
}
