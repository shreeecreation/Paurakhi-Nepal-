import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/search/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'bloc/search_bloc.dart';
import 'domain/filter_saver.dart';
import 'domain/search_value.dart';

class OptionsDialog extends StatefulWidget {
  const OptionsDialog({Key? key}) : super(key: key);

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  final List<DropdownMenuItem> _options = DropdownList.allCategory;
  final Set<String> _checkedValues = {};
  List<String> choosed = [];
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadCheckboxState();
  }

  Future<void> _loadCheckboxState() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _checkedValues.addAll(_prefs.getStringList('checkedValues') ?? []);
    });
  }

  void _saveCheckboxState() {
    _prefs.setStringList('checkedValues', _checkedValues.toList());
  }

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
                  title: option.child,
                  value: _checkedValues.contains(option.value),
                  onChanged: (checked) {
                    final index = _options.indexOf;
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
                    _saveCheckboxState(); // Save the checked state
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
                    FilterSaver.saveFilter(choosed.toString(), 0);
                    FilterSaver.getFilter();
                    Navigator.pop(context);
                    Filter.type = 0;
                    Get.find<SearchControllerHome>().currentPage = 1;
                    Get.find<SearchControllerHome>().loadProducts(false);
                    BlocProvider.of<SearchBloc>(context).add(SearchStartEvent());
                  },
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, elevation: 0),
                  child: const Text('Sell'),
                  onPressed: () {
                    FilterSaver.saveFilter(choosed.toString(), 1);
                    Filter.type = 1;
                    Get.find<SearchControllerHome>().loadProducts(false);
                    Get.find<SearchControllerHome>().currentPage = 1;
                    FilterSaver.getFilter();
                    Navigator.pop(context);
                    BlocProvider.of<SearchBloc>(context).add(SearchStartEvent());
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
