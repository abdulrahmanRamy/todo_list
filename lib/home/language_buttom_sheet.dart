import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/home/app_colors.dart';
import '../provider/app_provider.dart';

class LanguageButtomSheet extends StatefulWidget {
  const LanguageButtomSheet({super.key});

  @override
  State<LanguageButtomSheet> createState() => _LanguageButtomSheetState();
}

class _LanguageButtomSheetState extends State<LanguageButtomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              provider.changeLanguage('en');
            },
            child: provider.appLanguage == 'en'?
                getSelctedItemWidget(AppLocalizations.of(context)!.english,):
                getUnSelctedItemWidget(AppLocalizations.of(context)!.english,)
          ),
          SizedBox(height: 15,),
          InkWell(
            onTap: (){
              provider.changeLanguage('ar');
            },
            child: provider.appLanguage == 'ar'?
            getSelctedItemWidget(AppLocalizations.of(context)!.arabic,):
            getUnSelctedItemWidget(AppLocalizations.of(context)!.arabic,)
          ),
          SizedBox(height: 15,),
        ],
      ),
    );
  }

  Widget getSelctedItemWidget(String text){
    return Row(
      children: [
        Text(text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.primaryColor,
          ),),
        SizedBox(width: 250,),
        Icon(Icons.check,size: 25,color: AppColors.primaryColor,)
      ],
    );
  }

  Widget getUnSelctedItemWidget(String text){

    return Text(text,
    style: Theme.of(context).textTheme.bodyLarge,);
  }
}
