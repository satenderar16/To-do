import 'package:appml/controller_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'editing_page.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final Function() onMoreTap;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;

   InfoCard(
      {required this.title,
      this.body =
          """Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudi conseqr!""",
      required this.onMoreTap,
      this.subIcon = const CircleAvatar(
        child: Icon(
          Icons.directions,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        radius: 25,
      ),
      this.subInfoText = "545 miles",
      this.subInfoTitle = "Directions",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: const RadialGradient(
            colors: [Colors.orangeAccent, Colors.orange],
            focal: Alignment.topCenter,
            radius: .85,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 75,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: GestureDetector(
                  onTap: onMoreTap,
                  child: Center(
                      child: Text(
                    "More",
                    style: TextStyle(color: Colors.orange),
                  )),
                ),
              ),
            ],
          ),
          // SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: 230,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, ind) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Chip(
                          shape:const StadiumBorder(
                            side: BorderSide(
                              color: Colors.transparent, // Custom border color
                              width: 1, // Border width
                            ),
                          ),
                          label: Text(
                            "bhadd bhai $ind",
                            style: TextStyle(
                                color: Colors.orange.withOpacity(.75),
                                fontSize: 14),
                          )),
                    )),
          ),

          const SizedBox(height: 5),

        ],
      ),
    );
  }
}



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


