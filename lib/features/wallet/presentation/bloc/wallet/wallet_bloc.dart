import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/data/repos/store.dart';
import 'package:tranquil_life/app/domain/repos/store.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/wallet/data/models/card_data_model.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

abstract class _Keys {
  static const cardsKey = 'cards';
  static const defaultKey = 'default';
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(const WalletState()) {
    on<InitWallet>(_initWallet);
    on<SetDefaultCard>(_setDefaultCard);
    on<AddCard>(_addCard);
    on<RemoveCard>(_removeCard);
    on<ClearWallet>(_clearWallet);
  }

  IStore? _cardsStore;

  _initWallet(InitWallet event, Emitter<WalletState> emit) async {
    _cardsStore = SecuredHiveStore('cards-${event.userId}');
    await _cardsStore!.init();
    final map = _cardsStore!.get<List>(_Keys.cardsKey);
    final cards = map?.map((e) => CardDataModel.fromJson(Map.from(e))).toList();
    if (cards?.isEmpty ?? true) {
      add(AddCard(CardData.virtual()));
      return;
    }
    emit(state.copyWith(
      cards: cards,
      defaultIndex: _cardsStore!.get(_Keys.defaultKey),
    ));
  }

  _setDefaultCard(SetDefaultCard event, Emitter<WalletState> emit) async {
    emit(state.copyWith(defaultIndex: event.defaultIndex));
    _cardsStore?.set(_Keys.defaultKey, event.defaultIndex);
  }

  _addCard(AddCard event, Emitter<WalletState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    final cards = [...?state.cards, event.data];
    final map = cards.map((e) => e.toJson()).toList();
    await _cardsStore?.set(_Keys.cardsKey, map);
    emit(state.copyWith(cards: cards, status: OperationStatus.success));
  }

  _removeCard(RemoveCard event, Emitter<WalletState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    final newCards = List<CardData>.from(state.cards!)..remove(event.data);
    final map = newCards.map((e) => e.toJson()).toList();
    await _cardsStore?.set(_Keys.cardsKey, map);
    emit(state.copyWith(status: OperationStatus.success, cards: newCards));
  }

  _clearWallet(ClearWallet event, Emitter<WalletState> emit) async {
    if (true)

    ///TODO: user chooses to clear cards
    {
      emit(state.copyWith(status: OperationStatus.loading));
      await _cardsStore?.deleteAll(closeBox: true);
      emit(state.copyWith(status: OperationStatus.success, cards: null));
    } else {
      await _cardsStore?.deleteAll(keys: [], closeBox: true);
      emit(state.copyWith(cards: null));
    }
    _cardsStore = null;
  }
}
