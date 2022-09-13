import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/buttons.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/edit_card/edit_card_bloc.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/card_widget.dart';

class AddCardScreen extends StatefulWidget {
  ///argument is [CardData]
  static const routeName = 'add_card_screen';
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  static final _networks = <CardType, Widget>{
    CardType.mastercard: const Image(
        image: AssetImage('assets/images/wallet/networks/mastercard_dark.png')),
    CardType.visa: Image(
      image: const AssetImage('assets/images/wallet/networks/visa.png'),
      color: ColorPalette.blue[800],
    ),
    CardType.verve: const Image(
      image: AssetImage('assets/images/wallet/networks/verve.png'),
    ),
  };

  final _formKey = GlobalKey<FormState>();
  late EditCardBloc cardBloc;

  bool isCardTypePicked = false;

  @override
  void didChangeDependencies() {
    cardBloc = context.read<EditCardBloc>();
    if (cardBloc.state.data == null) {
      cardBloc.add(SetCardData(
        ModalRoute.of(context)!.settings.arguments as CardData? ??
            CardData.empty(),
      ));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const _AppBar(),
      body: UnfocusWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 4),
                AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: BlocBuilder<EditCardBloc, EditCardState>(
                    builder: (context, state) =>
                        CardWidget(cardData: state.data ?? CardData.empty()),
                  ),
                ),
                const SizedBox(height: 24),
                Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme:
                        WidgetsThemeData.inputDecorationTheme.copyWith(
                      fillColor: Colors.white,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BlocBuilder<EditCardBloc, EditCardState>(
                            builder: (context, state) {
                              return DropdownButtonFormField2<CardType>(
                                itemHeight: 44,
                                buttonHeight: 36,
                                value: state.data?.type,
                                itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(16),
                                ),
                                dropdownDecoration: BoxDecoration(
                                  boxShadow: WidgetsThemeData.dropDownShadow,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hint: const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text('Select your card network'),
                                ),
                                items: _networks.entries
                                    .map((e) => DropdownMenuItem(
                                          value: e.key,
                                          child: e.value,
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  isCardTypePicked = true;
                                  cardBloc.add(SetCardData(
                                    cardBloc.state.data!.copyWith(type: val),
                                  ));
                                },
                                validator: (val) {
                                  if (val == null) {
                                    return "Please select the right option";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            maxLength: 19,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Card number',
                            ),
                            onChanged: (number) => cardBloc
                                .add(SetCardData(cardBloc.state.data!.copyWith(
                              cardNumber: number,
                              type: isCardTypePicked
                                  ? null
                                  : cardBloc.checkTypeWithNumber(number),
                            ))),
                            validator: cardBloc.validateCardNumber,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.characters,
                            decoration: const InputDecoration(
                              hintText: 'Card-holder name',
                            ),
                            onChanged: (val) => cardBloc.add(SetCardData(
                              cardBloc.state.data!.copyWith(holderName: val),
                            )),
                            validator: (val) {
                              if (val?.isEmpty ?? true) {
                                return 'What is the name on the front of the card?';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            maxLength: 5,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Expiry date',
                            ),
                            onChanged: (val) => cardBloc.add(SetCardData(
                              cardBloc.state.data!.copyWith(expiryDate: val),
                            )),
                            validator: cardBloc.validateCardExpiryDate,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            maxLength: 4,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              hintText: 'CVV',
                            ),
                            validator: cardBloc.validateCardCVV,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends CustomAppBar {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCardBloc, EditCardState>(
      builder: (context, state) {
        return CustomAppBar(
          title: 'Customize Your Card',
          actions: [
            if (state.data?.props.every((e) {
                  print(e);
                  print(e is String);
                  return e is String ? e.isNotEmpty : true;
                }) ??
                false)
              AppBarAction(
                child: BlocListener<EditCardBloc, EditCardState>(
                  listenWhen: (prev, curr) => prev.data != curr.data,
                  listener: (context, state) {},
                  child: const Icon(Icons.check),
                ),
                onPressed: () {
                  context.read<EditCardBloc>().add(const SetCardData(null));
                },
              ),
          ],
        );
      },
    );
  }
}
