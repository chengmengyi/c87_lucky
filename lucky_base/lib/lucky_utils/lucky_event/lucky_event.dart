import 'package:event_bus/event_bus.dart';

final EventBus eventBus=EventBus();

class LuckyEvent{
  int luckyCode;
  int? intValue;
  bool? boolValue;
  LuckyEvent({
    required this.luckyCode,
    this.intValue,
    this.boolValue,
}){
    eventBus.fire(this);
  }
}