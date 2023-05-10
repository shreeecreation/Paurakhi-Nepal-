import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'domain/filter_saver.dart';

class OptionsDialog extends StatefulWidget {
  const OptionsDialog({super.key});

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

final List<String> _options = DropdownList.allCategory;

class _OptionsDialogState extends State<OptionsDialog> {
  final Set<String> _checkedValues = {};
  List<String> choosed = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select options'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _options
              .map(
                (option) => CheckboxListTile(
                  title: Text(option),
                  value: _checkedValues.contains(option),
                  onChanged: (checked) {
                    final index = _options.indexOf(option);
                    if (!choosed.contains(index.toString())) {
                      choosed.add(index.toString());
                    }
                    if (checked!) {
                      _checkedValues.add(option);
                    } else {
                      _checkedValues.remove(option);
                    }
                    setState(() {});
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
                  },
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, elevation: 0),
                  child: const Text('Sell'),
                  onPressed: () {
                    FilterSaver.saveFilter(choosed, 1);

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
