import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../core/app_manage/color_manager.dart';
import '../core/app_manage/values_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onSaved,
    this.controller,
    this.validator,
    this.label,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.iconData,
    this.onTapIcon,
    this.obscureText = false,
    this.hint,
    this.prefixWidget,
    this.errorText,
    this.autofocus = false,
    this.maxLength,
    this.inputFormatters,
  });

  final String? hint, label;
  final String? errorText;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool autofocus;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  // final int? maxLines, maxLength, minLines;
  final IconData? iconData;
  final Widget? prefixWidget;
  final void Function()? onTapIcon;
  final bool obscureText;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(label, style: context.titleLarge),
        // const SizedBox(height: AppSize.s12),
        TextFormField(
          cursorColor: ColorManager.secondary,
          cursorHeight: AppSize.s20,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          onSaved: onSaved,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          maxLength: maxLength,
          autofocus: autofocus,
          inputFormatters: inputFormatters,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          decoration: _buildInputDecoration(context),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      prefixIcon: prefixIcon == null
          ? null
          : prefixWidget ??
              Container(
                height: 50.0,
                width: 50.0,
                margin: EdgeInsets.only(
                    left: context.isEnLocale ? AppSize.s0 : AppMargin.m14,
                    right: context.isEnLocale ? AppMargin.m14 : AppSize.s0),
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                          context.isEnLocale ? AppSize.s0 : AppSize.s4),
                      bottomRight: Radius.circular(
                          context.isEnLocale ? AppSize.s0 : AppSize.s4),

                      ///
                      bottomLeft: Radius.circular(
                          context.isEnLocale ? AppSize.s4 : AppSize.s0),
                      topLeft: Radius.circular(
                          context.isEnLocale ? AppSize.s4 : AppSize.s0),
                    )),
                child: Icon(prefixIcon, color: Colors.white),
              ),
      suffixIcon: GestureDetector(
        onTap: onTapIcon,
        child: Icon(
          iconData,
          size: 25.0,
          color: ColorManager.grey,
        ),
      ),
      hintText: hint,
      errorText: errorText,

      // enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(AppSize.s4),
      //     borderSide: const BorderSide(
      //       width: AppSize.s1_5,
      //       color: ColorManager.primary,
      //     )),
      // disabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(AppSize.s4),
      //     borderSide: const BorderSide(
      //       width: AppSize.s1_5,
      //       color: ColorManager.textGray,
      //     )),
      // errorBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(AppSize.s4),
      //     borderSide: const BorderSide(
      //       width: AppSize.s1_5,
      //       color: ColorManager.error,
      //     )),
    );
  }
}
