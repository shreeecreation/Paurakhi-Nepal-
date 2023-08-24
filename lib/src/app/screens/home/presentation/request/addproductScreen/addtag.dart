import 'package:flutter/material.dart';

class TagGenerator {
  static List<String> tags =
      []; // Move the tags list outside the dialog function

  static Future<List<String>?> showTagDialog(BuildContext context) async {
    return showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Tags'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Wrap(
                spacing: 8.0,
                children: [
                  ...tags.map((tag) {
                    return InputChip(
                      label: Text(tag),
                      onDeleted: () {
                        setState(() {
                          tags.remove(tag);
                        });
                      },
                    );
                  }).toList(),
                  InputChip(
                    label: const Text('Add Tag'),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          final TextEditingController controller =
                              TextEditingController();

                          return AlertDialog(
                            title: const Text('Add Tag'),
                            content: TextField(
                              controller: controller,
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                child: const Text('Add'),
                                onPressed: () {
                                  setState(() {
                                    final String tag = controller.text.trim();
                                    if (tag.isNotEmpty) {
                                      tags.add(tag);
                                      // Remove the line below to prevent modifying Tag.allTag
                                      // Tag.allTag.add(tag);
                                    }
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(tags);
              },
            ),
          ],
        );
      },
    );
  }
}
