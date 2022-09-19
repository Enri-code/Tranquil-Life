import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';

class EditProfileTile extends StatelessWidget {
  const EditProfileTile({
    Key? key,
    required this.title,
    this.suffix,
    this.suffixFieldValue,
    this.onDoneEditing,
  })  : assert(suffix != null || suffixFieldValue != null),
        super(key: key);

  final String title;
  final String? suffixFieldValue;
  final Widget? suffix;
  final Function(String newValue)? onDoneEditing;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: ColorPalette.green[200],
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            const SizedBox(width: 16),
            Flexible(
              child: suffix ??
                  TextFormField(
                    maxLines: null,
                    initialValue: suffixFieldValue,
                    enabled: onDoneEditing != null,
                    textAlign: TextAlign.right,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: 'Previous: $suffixFieldValue',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onFieldSubmitted: onDoneEditing,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
