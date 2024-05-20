import 'package:equatable/equatable.dart';

sealed class ItemsPaginationEvent extends Equatable {
  const ItemsPaginationEvent();
  @override
  List<Object> get props => [];
}

class GetItemsPaginationEvent extends ItemsPaginationEvent{
  const GetItemsPaginationEvent();
}

class GetMoreItemsPaginationEvent extends ItemsPaginationEvent{
  const GetMoreItemsPaginationEvent();
}
class RefreshItemsPaginationEvent extends ItemsPaginationEvent{
  const RefreshItemsPaginationEvent();
}