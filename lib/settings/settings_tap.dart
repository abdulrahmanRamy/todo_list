// import 'package:flutter/material.dart';
//
// class SettingsTap extends StatelessWidget {
//   const SettingsTap({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.orange,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/home/app_colors.dart';
import 'package:todo_list/provider/app_provider.dart';
import 'package:todo_list/provider/auth_user_Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../home/language_buttom_sheet.dart';
import '../home/theme_buttom_sheet.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return InkWell(
      onTap: (){
        showLanguageBottomSheet();
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.appLanguage == 'en'?
              AppLocalizations.of(context)!.english:
              AppLocalizations.of(context)!.arabic,
              style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appLanguage == 'en'?
                  AppLocalizations.of(context)!.english:
                  AppLocalizations.of(context)!.english,
                    style: Theme.of(context).textTheme.titleLarge,),
                  Icon(Icons.arrow_drop_down,size: 35,)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.light,
              style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(height: 15,),
            InkWell(
              onTap: (){
                showThemeBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.isDarkMode()?
                      AppLocalizations.of(context)!.dark:
                      AppLocalizations.of(context)!.light,
                      style: Theme.of(context).textTheme.titleLarge,),
                    Icon(Icons.arrow_drop_down,size: 35,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageButtomSheet()
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ThemeButtomSheet()
    );
  }
}
