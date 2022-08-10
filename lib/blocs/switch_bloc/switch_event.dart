// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'switch_bloc.dart';

abstract class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

class SwithcSetValueEvent extends SwitchEvent {
  final bool switchValue;
  
  SwithcSetValueEvent({
    required this.switchValue,
  });

  @override
  List<Object> get props => [switchValue];
  
}

