import 'package:flutter/material.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/service/storage_service/db_firestore.dart';
import 'package:ikea_store/ui/admin/category/controller/category_controller.dart';
import 'package:ikea_store/ui/admin/category/view/add_category.dart';
import 'package:ikea_store/ui/admin/category/view/edit_category.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:provider/provider.dart';

class AdminCategoryScreen extends StatelessWidget {
  const AdminCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminCategoryController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: AppColors.dark)),
        title: const Text("Categories"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCategoryScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.dark,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: DbFirestoreService().getCategoryList(),
        // stream: provider.categoryStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final List<CategoryModel> categories =
                (snapshot.data!.isSuccess) ? snapshot.data?.data : [];

            return categories.isEmpty
                ? const Center(child: Text('Categories is empty'))
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return ListTile(
                        onLongPress: () => provider.deleteCategory(context, category),
                        title: Text(category.name),
                        leading: Image.network(category.imageUrl),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditCategoryScreen(category: category),
                                  ));
                            },
                            icon: Icon(Icons.edit)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(category.id),
                            Text(category.description),
                          ],
                        ),
                        // isThreeLine: true,
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: categories.length);
          }
          return const Center(child: Text('Some text'));
        },
      ),
    );
  }
}
