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
import 'dart:io';

import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  CategoryModel? _category;
  List<CategoryModel> _categories = [];
  File? _image;

  // List<File> _images = [];
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

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  _getCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('category').get();
      List<CategoryModel> categories = [];
      for (var element in snapshot.docs) {
        categories.add(CategoryModel.fromJson(element.data()));
      }
      setState(() {
        _categories = categories;
      });
    } catch (e) {}
  }

  // Future<void> _getImagesFromGallery() async {
  //   List<File> selectedImages = [];
  //
  //   for (int i = 0; i < 5; i++) {
  //     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,);
  //     if (pickedFile != null) {
  //       selectedImages.add(File(pickedFile.path));
  //     }
  //   }
  //
  //   setState(() {
  //     _images = selectedImages;
  //   });
  // }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          TextButton(
            onPressed: () {
              ProductModel newProduct = ProductModel(
                name: _nameController.text,
                description: _descriptionController.text,
                price: double.parse(_priceController.text),
                categoryId: _category!.id,
              );
              Provider.of<ProductProvider>(context, listen: false)
                  .addProduct(context, newProduct, _image!);
            },
            child: Text(
              'Save',
              style: AppStyle.button,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            AppImages.arrowBack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
