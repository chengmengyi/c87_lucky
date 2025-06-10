import 'package:event_bus/event_bus.dart';

final EventBus eventBus=EventBus();

class LuckyEvent{
  int luckyCode;
  int? intValue;
  bool? boolValue;
  double? doubleValue;
  dynamic dynamicValue;
  LuckyEvent({
    required this.luckyCode,
    this.intValue,
    this.boolValue,
    this.doubleValue,
    this.dynamicValue,
}){
    eventBus.fire(this);
  }
}