import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';

class RateConsultationDialog extends StatefulWidget {
  const RateConsultationDialog({Key? key}) : super(key: key);

  @override
  State<RateConsultationDialog> createState() => _RateConsultationDialogState();
}

class _RateConsultationDialogState extends State<RateConsultationDialog> {
  int? rating;
  String? message;
  bool displayMessageBox = false;

  @override
  Widget build(BuildContext context) {
    const smallPadding = SizedBox(height: 20);
    final consultant = context.read<ChatBloc>().state.consultant!;
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 24, bottom: 16),
        color: Colors.grey[100],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white38,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white54,
                    ),
                    child: UserAvatar(imageUrl: consultant.avatarUrl, size: 64),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    consultant.displayName,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            smallPadding,
            Text(
              'How was your consultation with\n${consultant.displayName}?',
              textAlign: TextAlign.center,
            ),
            smallPadding,
            if (displayMessageBox)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "What could we do better?",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 21,
                    ),
                  ),
                  onChanged: (val) => setState(() => message = val),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: _RateWidget(
                  onRate: (chosenRating) {
                    setState(() => rating = chosenRating);
                  },
                ),
              ),
            const Divider(color: Colors.white, thickness: 1.5, height: 32),
            TextButton(
              onPressed: rating == null
                  ? null
                  : () {
                      if (displayMessageBox || rating! > 3) {
                        Navigator.of(context).pop();
                      } else {
                        setState(() => displayMessageBox = true);
                      }
                    },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RateWidget extends StatefulWidget {
  const _RateWidget({Key? key, required this.onRate}) : super(key: key);
  final Function(int rating) onRate;

  @override
  State<_RateWidget> createState() => _RateWidgetState();
}

class _RateWidgetState extends State<_RateWidget> {
  int rating = -1;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 220),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(5, (index) {
          return IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() => rating = index + 1);
              widget.onRate(rating);
            },
            icon: AnimatedCrossFade(
              duration: kThemeAnimationDuration,
              crossFadeState: rating > index
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Icon(
                Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 36,
              ),
              secondChild: Icon(
                Icons.star,
                color: Theme.of(context).primaryColor,
                size: 36,
              ),
            ),
          );
        }),
      ),
    );
  }
}
