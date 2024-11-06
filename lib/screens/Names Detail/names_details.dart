import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_names/consts/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../models/category_model.dart';
import '../../models/model.dart';
import '../../providers/category_provider.dart';
import '../../providers/favorites_provider.dart';

class NameDetailScreen extends StatefulWidget {
  final NameModel name;

  const NameDetailScreen({super.key, required this.name});

  @override
  State<NameDetailScreen> createState() => _NameDetailScreenState();
}

class _NameDetailScreenState extends State<NameDetailScreen> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    flutterTts.stop();  // Stop the TTS if the screen is disposed
    super.dispose();
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage("en-US");  // Set language, you can modify it
    await flutterTts.setPitch(1.0);  // Set pitch, range from 0.5 to 2.0
    await flutterTts.speak(widget.name.nameTitle);  // Convert text to speech
  }

  Future<void> _stop() async {
    await flutterTts.stop();  // Stop the TTS
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.name.nameTitle,
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.mainColor,
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                Consumer<FavoritesProvider>(
                  builder: (context, favoritesProvider, child) {
                    final isFavorite = favoritesProvider.isFavorite(widget.name);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          favoritesProvider.removeFromFavorites(widget.name);
                        } else {
                          favoritesProvider.addToFavorites(widget.name);
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Meaning:',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    hintText: widget.name.nameMeaning,
                    hintStyle: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainColor),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Brief Explanation:',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  enabled: false,
                  maxLines: 7,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: widget.name.nameDescription,
                    hintStyle: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainColor),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Category:',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) {
                    if (categoryProvider.isLoadingCategories) {
                      return const CircularProgressIndicator();
                    }
                    final category = categoryProvider.categories.firstWhere(
                          (cat) => cat.categoryId == widget.name.nameCategory,
                      orElse: () => Category(
                          categoryId: '1',
                          categoryName: widget.name.nameCategory),
                    );

                    return TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: category.categoryName,
                      ),
                      readOnly: true,
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            color: AppColors.mainColor,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.share,
                          color: Colors.white, size: 25),
                      onPressed: () {
                        Share.share(widget.name.nameTitle);
                      },
                    ),
                    const Text('Share', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_circle_filled,
                          color: Colors.white, size: 25),
                      onPressed: _speak,  // Call _speak method on tap
                    ),
                    const Text('Listen', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon:
                      const Icon(Icons.copy, color: Colors.white, size: 25),
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.name.nameTitle));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Name copied to clipboard!'),
                          ),
                        );
                      },
                    ),
                    const Text('Copy', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

