import 'package:flutter/material.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/style.dart';

class UniversalInputWidget extends StatefulWidget {
  UniversalInputWidget({
    required this.hintText,
    super.key,
    this.keyboardType = TextInputType.name,
    this.isSecure = false,
    this.controller,
    this.onChanged,
  });

  TextEditingController? controller;
  String hintText;
  TextInputType keyboardType;
  bool isSecure;
  ValueChanged? onChanged;

  @override
  State<UniversalInputWidget> createState() => _UniversalInputWidgetState();
}

class _UniversalInputWidgetState extends State<UniversalInputWidget> {
  late bool isVisible;

  @override
  void initState() {
    isVisible = widget.isSecure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        textInputAction: TextInputAction.next,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        obscureText: isVisible,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          suffixIcon: widget.isSecure
              ? IconButton(
                  splashRadius: 30,
                  onPressed: () {
                    isVisible = !isVisible;

                    setState(() {});
                  },
                  icon:
                      Icon(isVisible ? Icons.visibility_off : Icons.visibility),
                )
              : null,
          hintStyle: AppStyle.body2.copyWith(
            color: AppColors.c8391A1,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          fillColor: AppColors.cF7F8F9,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.cDADADA),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.c1A73E8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.cE00000),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.cC1C1C2),
          ),
        ),
      );
}
