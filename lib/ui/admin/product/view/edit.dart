import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/ui/admin/product/controller/products_controller.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;

  const EditProductPage({required this.product, super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _image;
  CategoryModel? _category;
  List<CategoryModel> _categories = [];

  _getCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('category').get();
      List<CategoryModel> categories = [];
      for (var element in snapshot.docs) {
        categories.add(CategoryModel.fromJson(element.data()));
      }

      for (var element in categories) {
        if (element.id == widget.product.categoryId) {
          _category = element;
        }
      }

      setState(() {
        _categories = categories;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error getting categories: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description;
    _priceController.text = widget.product.price.toString();
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  void _saveChanges() {
    String updatedName = _nameController.text;
    String updatedDescription = _descriptionController.text;
    double updatedPrice = double.parse(_priceController.text);
    String updatedCategory = _category!.id;

    // Create the updated product object
    ProductModel updatedProduct = widget.product.copyWith(
      name: updatedName,
      description: updatedDescription,
      price: updatedPrice,
      categoryId: updatedCategory,
    );
    Provider.of<ProductProvider>(context, listen: false)
        .updateProduct(context, updatedProduct, _image);
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
          icon: SvgPicture.asset(AppImages.arrowBack),
        ),
        title: const Text('Edit Product'),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: Text(
              'Update',
              style: AppStyle.button,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Product Description'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Product Price'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: const Text('Pick Images from Gallery'),
            ),
            _image != null
                ? SizedBox(
                    height: 200,
                    child: Image.file(_image!),
                  )
                : Container(),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: _category,
              // value: 1,
              items: _categories
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      // value: 1,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _category = newValue as CategoryModel;
                });
              },
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
