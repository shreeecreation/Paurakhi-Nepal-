import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'domain/filter_saver.dart';
import 'domain/search_value.dart';

class OptionsDialog extends StatefulWidget {
  const OptionsDialog({super.key});

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  final List<DropdownMenuItem> _options = DropdownList.allCategory;
  final Set<String> _checkedValues = {};
  List<String> choosed = [];

  @override
  Widget build(BuildContext context) {
    print(_options);
    return AlertDialog(
      title: const Text('Select options'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _options
              .map(
                (option) => CheckboxListTile(
                  title: option.child,
                  value: _checkedValues.contains(option.value),
                  onChanged: (checked) {
                    final index = _options.indexOf(option);
                    if (!choosed.contains(index.toString())) {
                      choosed.add(index.toString());
                    }
                    if (checked!) {
                      _checkedValues.add(option.value);
                    } else {
                      _checkedValues.remove(option.value);
                    }
                    setState(() {
                      if (!SearchValue.category.contains(option.value)) {
                        SearchValue.category.add(option.value);
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            Text(
              "Type",
              style: AppStyles.text18PxBold,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, elevation: 0),
                  child: const Text('Request'),
                  onPressed: () {
                    FilterSaver.saveFilter(choosed, 0);
                    FilterSaver.getFilter();
                    Navigator.pop(context);
                    SearchValue.type = "request";
                  },
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, elevation: 0),
                  child: const Text('Sell'),
                  onPressed: () {
                    FilterSaver.saveFilter(choosed, 1);
                    SearchValue.type = "save";

                    FilterSaver.getFilter();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Future<Set<String>?> showOptionsDialog(BuildContext context) async {
  return showDialog<Set<String>?>(
    context: context,
    builder: (BuildContext context) {
      return const OptionsDialog();
    },
  );
}
