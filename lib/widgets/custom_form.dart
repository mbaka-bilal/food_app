import 'package:flutter/material.dart';
import 'package:food_app/utils/appstyles.dart';

class CustomForm extends StatefulWidget {
  const CustomForm(
      {super.key,
      this.hint,
      required this.width,
      this.leading,
      this.hintStyle,
      required this.textEditingController,
      this.formFieldValidator,
      required this.isHidden,
      this.inputType});

  final double width;
  final TextEditingController textEditingController;
  final String? hint;
  final Widget? leading;
  final TextStyle? hintStyle;
  final FormFieldValidator? formFieldValidator;
  final bool isHidden;
  final TextInputType? inputType;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool _hidden = false;

  @override
  void initState() {
    super.initState();
    _hidden = widget.isHidden;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.alabaster, borderRadius: BorderRadius.circular(10)),
      width: widget.width,
      child: TextFormField(
        controller: widget.textEditingController,
        style: const TextStyle(color: AppColors.grey),
        keyboardType: widget.inputType,
        obscureText: _hidden,
        validator: ((value) => widget.formFieldValidator!(value)),
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black45)),
            hintText: widget.hint,
            hintStyle: widget.hintStyle,
            prefixIcon: widget.leading,
            suffixIcon: (widget.isHidden)
                ? IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        _hidden = !_hidden;
                      });
                    },
                    icon: Icon(
                        (_hidden) ? Icons.visibility_off : Icons.visibility),
                    color: AppColors.black,
                  )
                : null),
      ),
    );
  }
}
