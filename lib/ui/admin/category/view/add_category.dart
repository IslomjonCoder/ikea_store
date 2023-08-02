import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ikea_store/ui/admin/category/controller/category_controller.dart';
import 'package:ikea_store/ui/admin/product/view/add_product_screen.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({Key? key}) : super(key: key);

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
        actions: [
          IconButton(
              onPressed: () {
                provider.addCategory(context);
              },
              icon: const Icon(Icons.done, color: AppColors.dark))
        ],
        title: Text('Add category'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            InputWidget(
              hint: 'Category name',
              onChanged: (value) => provider.setName = value,
            ),
            InputWidget(
              hint: 'Description',
              maxLine: 4,
              onChanged: (value) => provider.setDescription = value,
            ),
            (provider.imageFile == null)
                ? ElevatedButton(
                    onPressed: () async {
                      XFile? pickedFile =
                          await ImagePicker().pickImage(source: ImageSource.gallery);
                      provider.setImageFile = File(pickedFile!.path);
                    },
                    child: Text('Get image'))
                : Image.file(
                    provider.imageFile!,
                    height: 400,
                    width: 400,
                    fit: BoxFit.cover,
                  )
          ],
        ),
      ),
    );
  }
}
