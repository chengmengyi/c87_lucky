import 'package:event_bus/event_bus.dart';

final EventBus eventBus=EventBus();

class LuckyEvent{
  int luckyCode;
  LuckyEvent({
    required this.luckyCode,
}){
    eventBus.fire(this);
  }
}