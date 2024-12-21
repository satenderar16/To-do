import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './controller_widget.dart';
import 'package:get/get.dart';

class EditingPage extends StatelessWidget {
  EditingPage({super.key});
  final TextEditingController _titleText = TextEditingController();
  final TextEditingController _noteText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find<TodoController>();
     var todo =todoController.todos[todoController.indexOcard.value];
    _titleText.text = todo.title;
    _noteText.text = todo.note;
    List<String>? tag = todo.tags;
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: ThemeData.light().scaffoldBackgroundColor

          ),
            backgroundColor: ThemeData.light().appBarTheme.backgroundColor,
            pinned: true,
            expandedHeight: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: ThemeData.light().appBarTheme.backgroundColor,
              ),
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.select_all),
                  ],
                ),
              ),
              centerTitle: true,
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.zero,
            ),
          ),
          SliverPadding(padding: EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverToBoxAdapter(
              child: TextField(
                controller: _titleText,
                onChanged: (text){
                  todoController.todos[todoController.indexOcard.value].title=text;
                },
                style: TextStyle(
                  fontSize: 18,          // Font size
                  fontWeight: FontWeight.w600, // Font weight
                  color: Colors.black,    // Text color
                  letterSpacing: 1,    // Letter spacing
                  height: 1.5,           // Line height
                ),
                maxLines: null,
                decoration: InputDecoration(

                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0.0, // Adjust vertical padding
                    horizontal: 0.0,
                  ),
                  hintText: "Title",
                  hintStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w300),
            
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  // labelText: 'Password',
                ),
              ),
            ),
          ),
          SliverPadding(padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            sliver: SliverFillRemaining(
              hasScrollBody: false,
              child: TextField(
                controller: _noteText,
                maxLines: null,
                onChanged: (text){
                  todoController.todos[todoController.indexOcard.value].note=text;
                },
                decoration:  InputDecoration(
                  contentPadding:const EdgeInsets.symmetric(
                    // vertical: 0.0, // Adjust vertical padding
                    horizontal: 0.0,
                  ),
                  hintText: "Notes",
                  hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w300),
            
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  // labelText: 'Password',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
