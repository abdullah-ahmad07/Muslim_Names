import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../consts/app_colors.dart';
import '../../providers/favorites_provider.dart';

class FavoriteNames extends StatefulWidget {
  const FavoriteNames({super.key});

  @override
  State<FavoriteNames> createState() => _FavoriteNamesState();
}

class _FavoriteNamesState extends State<FavoriteNames> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorite Names',
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 23,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.white,
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favorites = favoritesProvider.favorites;
          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favorite names yet!',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favoriteNameTitle = favorites[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.mainColor),
                  ),
                  height: 80,
                  child: Center(
                    child: ListTile(
                      title: Text(
                        favoriteNameTitle,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          favoritesProvider.removeFromFavoritesByTitle(favoriteNameTitle);
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
