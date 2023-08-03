import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/ui/admin/category/view/add.dart';
import 'package:ikea_store/ui/admin/product/controller/products_controller.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const AddCategoryPage(),
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
        stream: FirebaseFirestore.instance
            .collection('category')
            .snapshots()
            .map((event) => event.docs.map((e) => CategoryModel.fromJson(e.data())).toList()),
        // stream: DbFirestoreService().getCategoryList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            List<CategoryModel> categories = snapshot.data!;
            return (categories.isEmpty)
                ? const Text('Categories is empty')
                : ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return ListTile(
                        onLongPress: () => Provider.of<ProductProvider>(context, listen: false)
                            .deleteCategory(context, category),
                        leading: SizedBox(
                          height: 40,
                          width: 40,
                          child: CachedNetworkImage(
                            imageUrl: category.imageUrl,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        title: Text(category.name),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.editCategory,
                              arguments: category,
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      );
                    },
                  );
          }
          return const Center(child: Text('Stream anything return'));
        },
      ),
    );
  }
}
