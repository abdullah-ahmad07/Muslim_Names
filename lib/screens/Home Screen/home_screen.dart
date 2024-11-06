import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_names/consts/app_assets.dart';
import 'package:muslim_names/consts/app_colors.dart';
import 'package:muslim_names/screens/Favorite%20Names/favorite_names.dart';
import 'package:muslim_names/screens/Girls%20Names/girls_names.dart';

import '../Allah Name/Allah_names.dart';
import '../Boys Names/boys_names.dart';
import '../Muhammad Names/Muhammad_names.dart';
import '../Quranic Names/Quranic_names.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.mainColor,
            shape: RoundedRectangleBorder(
              // Rounded corners for the dialog
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              'Exit App?',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            content: Text(
              'Are you sure you want to exit the app?',
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pop(true), // Go back to previous screen
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    'Yes',
                    style: GoogleFonts.montserrat(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.mainColor,
          title: Text(
            'Muslim Baby Names',
            style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildGenderButton(
                      context: context,
                      label: 'Boys',
                      icon: AppAssets.boy,
                      color: AppColors.mainColor,
                      fontColor: Colors.white,
                      onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BoysNames(),
                        ),
                      );
                    },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildGenderButton(
                      context: context,
                      label: 'Girls',
                      icon: AppAssets.girl,
                      color: Colors.white,
                      borderColor: AppColors.mainColor,
                      fontColor: AppColors.mainColor,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GirlsNames(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildFavoritesButton(context),
              const SizedBox(height: 20),
              Text(
                'Popular Names:',
                style: GoogleFonts.rubik(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AllahName(),
                    ),
                  );
                },
                child: _buildPopularNameCard(
                  'Allah\'s Names',
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AllahName(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildPopularNameCard(
                'Muhammad\'s Names',
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MuhammadName(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildPopularNameCard(
                'Quranic Names',
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const QuranicName(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderButton({
    required BuildContext context,
    required String label,
    required String icon,
    required Color color,
    Color? borderColor,
    required Color fontColor,
     required void Function() onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        side: borderColor != null ? BorderSide(color: borderColor) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: fontColor,
            radius: 39,
            child: Image.asset(
              icon,
              height: 50,
              width: 50,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: fontColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesButton(context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FavoriteNames(),
            ),
          );
        },
        icon: const Icon(
          Icons.favorite,
          color: Colors.white,
          size: 36,
        ),
        label: Text(
          'Favorite Names',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  Widget _buildPopularNameCard(String name, void Function() onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mainColor),
      ),
      height: 100,
      child: ListTile(
        onTap: onTap,
        title: Center(
          child: Text(
            name,
            style: GoogleFonts.rubik(
              fontSize: 20,
              color: AppColors.mainColor,
            ),
          ),
        ),
      ),
    );
  }
}
