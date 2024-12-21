  import 'package:appml/todo_model.dart';
  import 'package:flutter/material.dart';
  import './controller_widget.dart';
  import 'package:get/get.dart';
  import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
  import './editing_page.dart';
  import 'package:flutter/services.dart';
  import './card_widget.dart';

  class HomePage extends StatelessWidget {
    HomePage({super.key});
    final TodoController controller = Get.put(TodoController());
    @override
    Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeData().scaffoldBackgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => EditingPage(), transition: Transition.fade,);
            controller.addTodo(TodoElement(title: '', note: '',));
            controller.indexOcard.value = controller.todos.length - 1;
          },
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: ThemeData().scaffoldBackgroundColor,
                systemOverlayStyle: buildSystemUiOverlayStyle(),
                pinned: true,
                expandedHeight: 50.0,
                flexibleSpace: Obx(() => FlexibleSpaceBar(
                    title: controller.SelectionUI.value ? appBarSelected() : const appBarNotSelected(),
                    centerTitle: true,
                    expandedTitleScale: 1,
                    titlePadding: EdgeInsets.zero,
                  ),
                ),
              ),

              // view for to_do listing
              controller.todosEmpty()
                  ? SliverPadding(padding: const EdgeInsets.all(8), sliver: SliverFillRemainingCenterTitle(),)
                  : SliverPadding(padding: const EdgeInsets.all(8.0),
                sliver: Obx(() => SliverMasonryGridTOdo(context, controller),),
                    ),
            ],
          ),
        ));
  }





  SliverMasonryGrid SliverMasonryGridTOdo(
      BuildContext context, TodoController controller) {
    return SliverMasonryGrid.count(
      crossAxisCount: (MediaQuery.of(context).size.width ~/ 200),
      mainAxisSpacing: 5,
      childCount: controller.todos.length,
      crossAxisSpacing: 5,
      itemBuilder: (context, index) {
        final todo = controller.todos[index];
        return ContainerW(
            title: todo.title, note: todo.note, tags: todo.tags, index: index);
      },
    );
  }

  SliverFillRemaining SliverFillRemainingCenterTitle() {
    return SliverFillRemaining(
      hasScrollBody: false,
      fillOverscroll: true,
      child: Center(
        child: Text(
          " Let's Create a new one ",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black.withOpacity(0.5),
          ),
          softWrap: true,
        ),
      ),
    );
  }

  SystemUiOverlayStyle buildSystemUiOverlayStyle() {
    return SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: ThemeData().scaffoldBackgroundColor);
  }
}

class appBarNotSelected extends StatelessWidget {
  const appBarNotSelected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.purple.shade50,
        ),

        // width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const TextField(
          // obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              // vertical: 0.0, // Adjust vertical padding
              horizontal: 0.0,
            ),
            hintText: "Search",
            hintStyle: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w400),
            icon: Icon(Icons.menu),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            // labelText: 'Password',
          ),
        ));
  }
}

class appBarSelected extends StatelessWidget {
  appBarSelected({
    super.key,
  });
  bool selAll = false;
  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.find<TodoController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              todoController.deleteSelected();
              todoController.SelectionUI.value = false;
            },
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              print(selAll);

              if (!selAll) {
                todoController.selectAll();
              } else {
                todoController.SeletionOIndices.clear();
                todoController.SelectionUI.value = false;
              }
              selAll = !selAll;
            },
            icon: Icon(Icons.select_all),
          )
        ],
      ),
    );
  }
}
