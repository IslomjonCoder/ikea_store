import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/ui/admin/category/controller/category_controller.dart';
import 'package:ikea_store/ui/admin/product/view/add_product_screen.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditCategoryScreen extends StatefulWidget {
  EditCategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  CategoryModel category;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  late TextEditingController nameController;

  late TextEditingController descController;
  @override
  void initState() {
    descController = TextEditingController(text: widget.category.description);
    nameController = TextEditingController(text: widget.category.name);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

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
                provider.setName = nameController.text;
                provider.setDescription = descController.text;
                provider.updateCategory(context, widget.category);
              },
              icon: const Icon(Icons.done, color: AppColors.dark))
        ],
        title: const Text('Edit category'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InputWidget(
              hint: 'Category name',
              controller: nameController,
              // onChanged: (value) => provider.setName = value,
            ),
            InputWidget(
              hint: 'Description',
              maxLine: 4,
              controller: descController,
              // onChanged: (value) => provider.setDescription = value,
            ),
            (provider.imageFile == null)
                ? Image.network(
                    widget.category.imageUrl,
                    height: 400,
                    width: 400,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    provider.imageFile!,
                    height: 400,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
            ElevatedButton(
                onPressed: () async {
                  XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  provider.setImageFile = File(pickedFile!.path);
                },
                child: const Text('Get image'))
          ],
        ),
      ),
    );
  }
}
