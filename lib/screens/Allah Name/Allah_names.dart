import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_names/consts/app_colors.dart';
import 'package:provider/provider.dart';
import '../../providers/names_provider.dart';
import '../Names Detail/names_details.dart';

class AllahName extends StatefulWidget {
  const AllahName({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AllahNameState();
  }
}

class _AllahNameState extends State<AllahName> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NameProvider>(context, listen: false).fetchNames('Allah');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.mainColor,
        title: const Text('Allah\'s Names'),
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
                          '${index+1}.',
                          style: GoogleFonts.rubik(
                            fontSize: 20,
                            color: AppColors.mainColor,
                          ),
                        ),
                        title: Text(
                          '            ${name.nameTitle}',
                          style: GoogleFonts.rubik(
                            fontSize: 20,
                            color: AppColors.mainColor,
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
                              builder: (context) => NameDetailScreen(name: name),
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
