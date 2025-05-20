import 'package:event_bus/event_bus.dart';

final EventBus eventBus=EventBus();

class LuckyEvent{
  int luckyCode;
  int? intValue;
  LuckyEvent({
    required this.luckyCode,
    this.intValue,
}){
    eventBus.fire(this);
  }
}