import 'package:amenda_cuts/Common/Constants/color_constants.dart';
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
    bool? isSearch,
    required bool isPrefix,
    required BuildContext context,
    icon}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    style: Theme.of(context).textTheme.bodySmall,
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
        // fillColor: Theme.of(context).cardColor,
        // filled: true,
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
                      )
                    : const Icon(
                        Iconsax.eye_slash,
                      ))
            : isSearch != null
                ? const Icon(
                    Iconsax.candle_2,
                    color: ColorConstants.appColor,
                  )
                : const SizedBox.shrink(),
        prefixIcon: isPrefix
            ? Icon(
                icon,
                color: const Color.fromARGB(255, 186, 186, 186),
              )
            : null,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 186, 186, 186)),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: ColorConstants.appColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)))),
  );
}
