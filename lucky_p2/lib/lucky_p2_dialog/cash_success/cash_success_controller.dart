import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_task_bean.dart';
import 'package:lucky_p2/lucky_p2_util/cash_utils.dart';

class CashSuccessController extends LuckyBaseController{
  clickKnow(CashTaskBean? cashTaskBean)async{
    await CashUtils.instance.deleteCashTask(cashTaskBean);
    LuckyRouters.instance.back();
  }

  clickClose(){
    LuckyRouters.instance.back();
  }
}