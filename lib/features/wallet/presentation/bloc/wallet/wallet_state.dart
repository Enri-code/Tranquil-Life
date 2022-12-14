part of 'wallet_bloc.dart';

class WalletState extends BlocStateBase {
  const WalletState({
    super.status,
    super.error,
    this.cards,
    this.defaultIndex = 0,
  });

  final int defaultIndex;
  final List<CardData>? cards;

  CardData get defaultCard => cards![defaultIndex];

  @override
  List<Object?> get props => [...super.props, cards, defaultIndex];

  @override
  WalletState copyWith({
    EventStatus? status,
    ApiError? error,
    List<CardData>? cards,
    int? defaultIndex,
  }) {
    return WalletState(
      status: status ?? this.status,
      error: error ?? this.error,
      cards: cards ?? this.cards,
      defaultIndex: defaultIndex ?? this.defaultIndex,
    );
  }
}
