part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class InitWallet extends WalletEvent {
  const InitWallet(this.userId);
  final int userId;
}

class SetDefaultCard extends WalletEvent {
  const SetDefaultCard(this.defaultIndex);
  final int defaultIndex;
}

class AddCard extends WalletEvent {
  const AddCard(this.data);
  final CardData data;
}

class UpdateCard extends WalletEvent {
  const UpdateCard(this.data);
  final CardData data;
}

class RemoveCard extends WalletEvent {
  const RemoveCard(this.data);
  final CardData data;
}

class ClearWallet extends WalletEvent {
  const ClearWallet();
}
