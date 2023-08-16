import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomDialog extends StatelessWidget {
  final String filePath;
  final bool isNetworkImage;

  const CustomDialog({Key? key, required this.filePath, required this.isNetworkImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.pop(context);
      
      Navigator.pop(context);},
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 200,
                  backgroundImage: isNetworkImage ? NetworkImage(filePath) : AssetImage(filePath) as ImageProvider,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Example usage of showDialog
void viewProfile(BuildContext context, String filePath, isNetworkImage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(filePath: filePath, isNetworkImage: isNetworkImage);
    },
  );
}
