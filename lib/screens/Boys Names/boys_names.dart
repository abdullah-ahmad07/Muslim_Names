import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_names/consts/app_assets.dart';
import 'package:muslim_names/consts/app_colors.dart';
import 'package:provider/provider.dart';
import '../../providers/names_provider.dart';
import '../Names Detail/names_details.dart';

class BoysNames extends StatefulWidget {
  const BoysNames({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BoysNamesState();
  }
}

class _BoysNamesState extends State<BoysNames> {
  final String _filterOption = 'Boys Names';
  bool _isSearching = false;
  bool _isAlphabetical = false;
  final TextEditingController _searchController = TextEditingController();
  String _selectedAlphabet = 'A';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NameProvider>(context, listen: false).fetchNames('Boys');
    });
  }



  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all(color: AppColors.mainColor, width: 2)),
            child: Center(
              child: Text(
                'Filter By',
                style: TextStyle(color: AppColors.mainColor, fontSize: 25),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(

                title: Text(
                  'Search',
                  style: TextStyle(color: AppColors.mainColor, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _isSearching = true;
                    _isAlphabetical = false;
                  });
                },
              ),
              ListTile(
                title: Text(
                  'Alphabetically',
                  style: TextStyle(color: AppColors.mainColor, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _isAlphabetical = true;
                    _isSearching = false;
                  });
                },
              ),

            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Filter By Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onChanged: (query) {
        Provider.of<NameProvider>(context, listen: false).searchNames(query);
      },
    );
  }

  Widget _buildAlphabetDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.mainColor,
          width: 2,
        ),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedAlphabet,
            items: List.generate(26, (index) {
              String letter = String.fromCharCode(65 + index); // A-Z
              return DropdownMenuItem<String>(
                value: letter,
                child: Text(letter, style: TextStyle(color: AppColors.mainColor)),
              );
            }),
            onChanged: (newValue) {
              setState(() {
                _selectedAlphabet = newValue!;
                Provider.of<NameProvider>(context, listen: false)
                    .filterNamesByAlphabet(newValue);
              });
            },
            iconEnabledColor: AppColors.mainColor, // Change icon color
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.mainColor,
        title: _isSearching
            ? _buildSearchBar()
            : _isAlphabetical
            ? _buildAlphabetDropdown()
            : Text(_filterOption),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 23,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
            onTap: _showFilterDialog,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Image.asset(
                AppAssets.filter,
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<NameProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ));
          } else if (provider.names.isEmpty) {
            return const Center(child: Text('No names found'));
          } else {
            return ListView.builder(
              itemCount: provider.names.length,
              itemBuilder: (context, index) {
                final name = provider.names[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.mainColor),
                    ),
                    height: 100,
                    child: Center(
                      child: ListTile(
                        leading: Text(
                          '${index + 1}.',
                          style: GoogleFonts.rubik(
                          fontSize: 20,
                          color: AppColors.mainColor,
                        ),
                        ),
                        title: Center(
                          child: Text(
                            name.nameTitle,
                            style: GoogleFonts.rubik(
                              fontSize: 20,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 23,
                            color: AppColors.mainColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NameDetailScreen(name: name),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NameDetailScreen(name: name),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
