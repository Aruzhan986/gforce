import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Lang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language),
      onPressed: () => _showLanguagePicker(context),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildLanguageOption(context, 'English', 'en'),
            _buildLanguageOption(context, 'Kazakh', 'kk'),
            _buildLanguageOption(context, 'Russian', 'ru'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, String language, String locale) {
    return ListTile(
      title: Text(language),
      onTap: () {
        context.setLocale(Locale(locale));
        Navigator.of(context).pop();
      },
    );
  }
}
