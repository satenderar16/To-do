import 'package:appml/controller_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'editing_page.dart';




//container Widgt with size

class ContainerW extends StatelessWidget {
  final int index;
 final String? title;
  final String? note;
  final List<String>? tags;
  final TodoController controller = Get.find<TodoController>();
    ContainerW({this.title,this.note,this.tags,required this.index,super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        if (controller.SelectionUI.value) {
          controller.toggleSelection(index);
          controller.indexOcard.value = index;
          HapticFeedback.lightImpact();
          controller.SelectionUI.value =
          controller.SeletionOIndices.isNotEmpty;
        } else {
          controller.indexOcard.value = index;
          Get.to(() => EditingPage(),
              transition: Transition.cupertinoDialog,
              duration:
              const Duration(milliseconds: 300));
        }
      },
      onLongPress: () {
        if (!controller.SelectionUI.value) {
          controller.SelectionUI.value = true;
        }
        controller.toggleSelection(index);
        HapticFeedback.lightImpact();
        controller.SelectionUI.value =
            controller.SeletionOIndices.isNotEmpty;
      },
      child: Container(
        child: Obx((){
            final isSelect = controller.isSelectItem(index);
            return Card(
            elevation: 0,
            color: ThemeData.light().cardColor,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(12), // Rounded corners
              side: BorderSide(
                color: Colors.grey, // Border color
                width: isSelect ? 1.5:0.4, // Border width
              ),
            ),
            child:  Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (title==null || title =='')? SizedBox(width: 0,):Text(
                    title!,
                    maxLines: 3,  // Limit text to 2 lines
                    overflow: TextOverflow.ellipsis,

                    style: ThemeData.light(useMaterial3: true).textTheme.bodyMedium,// Add "..." if it exceeds the maximum lines
                  ),const SizedBox(height: 8,),
                  (note==null || note =='')?const SizedBox(width: 0,):Text(
                    note!,
                    maxLines: 15,
                    style: Theme.of(context).textTheme.bodySmall,// Limit text to 2 lines
                    overflow: TextOverflow.ellipsis,  // Add "..." if it exceeds the maximum lines
                  ),SizedBox(height: 10,),
                  tags==null?const SizedBox(width: 0,):(tags!.length<=2?const Text('someTags'):const Text('lotsTags'))

                ],
              ),
            ),
          );
            },
        ),
      ),
    );
  }
}

Card containerW(BuildContext context, String text) {
  return  Card(
    elevation: 0,
    color: ThemeData.light().cardColor,
    shape: RoundedRectangleBorder(
      borderRadius:
      BorderRadius.circular(12), // Rounded corners
      side:const BorderSide(
        color: Colors.grey, // Border color
        width: 0.4, // Border width
      ),
    ),
    child:  Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16),
      child: Align(alignment: Alignment.centerLeft,
        child: Text(text),
      ),
    ),
  );
}


