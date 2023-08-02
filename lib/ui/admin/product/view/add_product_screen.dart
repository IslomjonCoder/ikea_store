import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ikea_store/ui/admin/product/controller/products_controller.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  int? selectedValue;
  @override
  void initState() {
    AdminProductsController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProductsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              provider.reset();
            },
            icon: const Icon(Icons.arrow_back, color: AppColors.dark)),
        actions: [
          IconButton(
              onPressed: () {
                provider.addProduct(context);
              },
              icon: const Icon(Icons.done, color: AppColors.dark))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InputWidget(
              hint: "Product name",
              onChanged: (value) => provider.productName = value,
            ),
            InputWidget(
              hint: "Description",
              inputAction: TextInputAction.newline,
              maxLine: 4,
              onChanged: (value) => provider.description = value,
            ),
            InputWidget(
              hint: "Price",
              inputType: TextInputType.number,
              onChanged: (value) => provider.price = double.parse(value),
            ),
            DropdownButton(
              value: selectedValue,
              items: List.generate(
                provider.getCategories.length,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text(provider.getCategories[index].name),
                ),
              ),
              onChanged: (value) {
                selectedValue = value;
                provider.categoryID = provider.getCategories[value!].id;
                setState(() {});
              },
            ),
            (provider.imageFile == null)
                ? ElevatedButton(
                    onPressed: () async {
                      XFile? pickedFile =
                          await ImagePicker().pickImage(source: ImageSource.gallery);
                      provider.imageFile = File(pickedFile!.path);
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

class InputWidget extends StatelessWidget {
  InputWidget({
    required this.hint,
    this.maxLine,
    this.inputAction = TextInputAction.next,
    this.inputType,
    this.onChanged,
    this.controller,
    super.key,
  });

  ValueChanged? onChanged;
  String hint;
  int? maxLine;
  TextEditingController? controller;
  TextInputAction? inputAction;
  TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        onChanged: onChanged,
        maxLines: maxLine,
        keyboardType: inputType,
        controller: controller,
        textInputAction: inputAction,
        decoration: InputDecoration(border: OutlineInputBorder(), hintText: hint),
      ),
    );
  }
}
