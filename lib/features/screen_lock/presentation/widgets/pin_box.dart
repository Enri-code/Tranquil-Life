import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tranquil_life/features/screen_lock/domain/screen_lock_store.dart';
import 'package:tranquil_life/features/screen_lock/presentation/bloc/lock_screen_bloc.dart';

class PinBox extends StatelessWidget {
  const PinBox(this.index, {Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(color: Colors.grey[100], depth: -3),
      child: SizedBox.square(
        dimension: keyPadSize,
        child: BlocBuilder<LockScreenBloc, LockScreenState>(
          builder: (context, state) {
            return AnimatedOpacity(
              duration: kThemeChangeDuration,
              opacity: state.pin.length - 1 < index ? 0 : 1,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text('*', style: TextStyle(fontSize: 64)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
