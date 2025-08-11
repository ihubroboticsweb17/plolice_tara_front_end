import 'package:edu_tara/core/utils/helper_function.dart';
import 'package:edu_tara/core/widgets/glassmorphism.dart';
import 'package:edu_tara/features/language/controller/language_controller.dart';
import 'package:edu_tara/features/welcome/controller/battery_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageList extends StatefulWidget {
  const LanguageList({super.key});

  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final batteryProvider = Provider.of<BatteryProvider>(
        context,
        listen: false,
      );

      final langProvider = Provider.of<LanguageProvider>(
        context,
        listen: false,
      );

      final defaultLang =
          batteryProvider.batteryModel?.data?[0].robot?.language ?? "";

      langProvider.setInitialLanguage(defaultLang);
      langProvider.fetchLanguages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<LanguageProvider>(
        builder: (context, langProvider, _) {
          if (langProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (langProvider.languages.isEmpty) {
            return const Center(
              child: Text(
                "No Languages available",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Column(
            children: [
              const SizedBox(height: 40),
              // Back Button
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Select Language',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BaseGlassmorphism(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3,
                        ),
                    itemCount: langProvider.languages.length,
                    itemBuilder: (context, index) {
                      final fullText = langProvider.languages[index];
                      final isSelected =
                          langProvider.selectedLanguage == fullText;

                      // Split language and voice info
                      final match = RegExp(
                        r'^(.+?)\s*\((.+?)\)$',
                      ).firstMatch(fullText);
                      final title =
                          match?.group(1)?.toUpperCase() ??
                          fullText.toUpperCase();
                      final subtitle = match?.group(2) ?? '';

                      return GestureDetector(
                        onTap: () {
                          langProvider.updateLanguage(
                            lang: fullText,
                            context: context,
                            batteryProvider: Provider.of<BatteryProvider>(
                              context,
                              listen: false,
                            ),
                            userId: userID,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black.withOpacity(0.3),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.greenAccent
                                  : Colors.white10,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.greenAccent
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      subtitle,
                                      style: const TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.greenAccent,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
