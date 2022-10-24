import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/buttons.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/edit_card/edit_card_bloc.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/wallet/wallet_bloc.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/card_widget.dart';

class CustomizeCardScreen extends StatefulWidget {
  ///argument is [CardData]
  static const routeName = 'add_card_screen';
  const CustomizeCardScreen({Key? key}) : super(key: key);

  @override
  State<CustomizeCardScreen> createState() => _CustomizeCardScreenState();
}

class _CustomizeCardScreenState extends State<CustomizeCardScreen> {
  static final _networks = <CardType, Widget>{
    CardType.mastercard: const Image(
        image: AssetImage('assets/images/wallet/networks/mastercard_dark.png')),
    CardType.americanExpress: const Image(
      image: AssetImage('assets/images/wallet/networks/american_express.png'),
    ),
    CardType.verve: const Image(
      image: AssetImage('assets/images/wallet/networks/verve.png'),
    ),
    CardType.visa: Image(
      image: const AssetImage('assets/images/wallet/networks/visa.png'),
      color: ColorPalette.blue[800],
    ),
  };

  final _formKey = GlobalKey<FormState>();
  late EditCardBloc cardBloc;

  bool isCardTypePicked = false;
  late bool isEditMode;

  @override
  void didChangeDependencies() {
    cardBloc = context.read<EditCardBloc>();
    final cardArg = ModalRoute.of(context)!.settings.arguments as CardData?;
    if (isEditMode = cardArg != null) cardBloc.add(SetCardData(cardArg));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _AppBar(
        isEditMode: isEditMode,
        onValidateForm: () => _formKey.currentState!.validate(),
      ),
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
                        CardWidget(cardData: state.data),
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
                                value: state.data.type,
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
                                    cardBloc.state.data.copyWith(type: val),
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
                          BlocListener<WalletBloc, WalletState>(
                            listenWhen: (previous, current) =>
                                current.status != OperationStatus.initial,
                            listener: (context, state) {
                              if (state.status == OperationStatus.loading) {
                                CustomLoader.display();
                              } else {
                                CustomLoader.remove();
                                if (state.status == OperationStatus.success) {
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: const SizedBox(height: 24),
                          ),
                          TextFormField(
                            maxLength: 19,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Card number',
                            ),
                            onChanged: (number) => cardBloc
                                .add(SetCardData(cardBloc.state.data.copyWith(
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
                              cardBloc.state.data.copyWith(holderName: val),
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
                              cardBloc.state.data.copyWith(expiryDate: val),
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
                            onChanged: (val) => cardBloc.add(SetCardData(
                              cardBloc.state.data.copyWith(CVV: val),
                            )),
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
  const _AppBar({
    Key? key,
    required this.isEditMode,
    required this.onValidateForm,
  }) : super(key: key);

  final bool isEditMode;
  final bool Function() onValidateForm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCardBloc, EditCardState>(
      builder: (context, state) {
        final isComplete = state.data.props.every(
          (e) => e is String ? e.isNotEmpty : true,
        );
        return CustomAppBar(
          title: '${isEditMode ? 'Edit Your' : 'Add A'} Card',
          actions: [
            if (isComplete)
              AppBarAction(
                child: const Icon(Icons.check),
                onPressed: () {
                  if (!onValidateForm()) return;
                  if (isEditMode) {
                    context.read<WalletBloc>().add(UpdateCard(state.data));
                  } else {
                    context.read<WalletBloc>().add(AddCard(state.data));
                  }
                  context.read<EditCardBloc>().add(const SetCardData(null));
                },
              ),
          ],
        );
      },
    );
  }
}
