import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/ui/admin/product/controller/products_controller.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditCategoryPage extends StatefulWidget {
  CategoryModel category;

  EditCategoryPage({required this.category, Key? key}) : super(key: key);

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final TextEditingController _nameController = TextEditingController();
  File? _imageFile;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.category.name;
  }

  void _getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  void _saveChanges() {
    String updatedName = _nameController.text;

    // Create the updated product object
    CategoryModel updatedCategory = widget.category.copyWith(
      name: updatedName,
    );
    Provider.of<ProductProvider>(context, listen: false).updateCategory(context, updatedCategory, _imageFile);
    // print(updatedProduct.toJson());
    // Navigator.pop(context); // Navigate back to the previous screen after saving changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            AppImages.arrowBack,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: Text(
              'Update',
              style: AppStyle.button,
            ),
          )
        ],
        title: const Text('Edit Category'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            ElevatedButton(
              onPressed: _getImage,
              child: const Text('Pick Images from Gallery'),
            ),
            _imageFile != null
                ? SizedBox(
                    height: 200,
                    child: Image.file(_imageFile!),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
