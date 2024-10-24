import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget commonTextField(
    {required TextEditingController controller,
    required String text,
    required int maxLines,
    required Function onChange,
    required bool isPassword,
    required bool obscure,
    required Function validator,
    Function? onTap,
    icon}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    style: const TextStyle(color: ColorConstants.appTextColor),
    expands: false,
    minLines: obscure ? 1 : null,
    obscureText: obscure,
    maxLines: obscure ? 1 : maxLines,
    validator: (value) {
      return validator(value);
    },
    onChanged: (value) {
      onChange(value);
    },
    decoration: InputDecoration(
        fillColor: ColorConstants.blackBackground,
        filled: true,
        hintText: text,
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap();
                  }
                },
                child: obscure
                    ? const Icon(
                        Iconsax.eye,
                        color: Color.fromARGB(255, 186, 186, 186),
                      )
                    : const Icon(
                        Iconsax.eye_slash,
                        color: Color.fromARGB(255, 186, 186, 186),
                      ))
            : const SizedBox.shrink(),
        prefixIcon: Icon(
          icon,
          color: const Color.fromARGB(255, 186, 186, 186),
        ),
        hintStyle: const TextStyle(color: Color.fromARGB(255, 186, 186, 186)),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: ColorConstants.appColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)))),
  );
}
