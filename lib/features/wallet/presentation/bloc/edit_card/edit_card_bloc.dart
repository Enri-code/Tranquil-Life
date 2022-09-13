import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';

part 'edit_card_event.dart';
part 'edit_card_state.dart';

class EditCardBloc extends Bloc<EditCardEvent, EditCardState> {
  static final _cardValidator = CreditCardValidator();

  EditCardBloc() : super(const EditCardState()) {
    on<SetCardData>(_setCardData);
  }

  CardType? checkTypeWithNumber(String? val) {
    if (val == null) return null;
    final result = _cardValidator.validateCCNum(val);
    result.ccType;
    switch (result.ccType) {
      case CreditCardType.mastercard:
        return CardType.mastercard;
      case CreditCardType.visa:
        return CardType.visa;
      default:
        return null;
    }
  }

  String? validateCardNumber(String? val) {
    if (val?.isEmpty ?? true) {
      return 'What is the 16-digit number on your card?';
    }
    if (val!.length < 16) {
      return '${16 - val.length} digits missing.';
    }
    final result = _cardValidator.validateCCNum(val);
    if (!result.isPotentiallyValid) return 'This card number is not valid';
    return null;
  }

  String? validateCardExpiryDate(String? val) {
    if (val?.isEmpty ?? true) {
      return 'What is the expiry date of the card?';
    }
    final result = _cardValidator.validateExpDate(val!);
    if (!result.isPotentiallyValid) return 'This card is invalid or expired';
    return null;
  }

  String? validateCardCVV(String? val) {
    if (val?.isEmpty ?? true) {
      return 'What is the number at the back of the card?';
    }
    add(SetCardData(state.data!.copyWith(CVV: val)));
    return null;
  }

  _setCardData(SetCardData event, Emitter<EditCardState> emit) {
    emit(state.copyWith(data: event.data));
  }
}
