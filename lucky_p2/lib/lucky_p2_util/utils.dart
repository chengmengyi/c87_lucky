import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/cash_type_bean.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/lucky_p2_cash_child/cash_child_controller.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';

String getMoneySymbol(){
  var code = Get.deviceLocale?.countryCode??"US";
  switch(code){
    case "BR": return "R\$";
    // case "VN": return "₫";
    // case "ID": return "Rp";
    // case "TH": return "฿";
    // case "RU": return "₽";
    // case "PH": return "₱";
    default: return "\$";
  }
}

double getMoneyByCountry(dynamic coins){
  try{
    var code = Get.deviceLocale?.countryCode??"US";
    switch(code){
      case "BR":
        return (Decimal.parse("$coins")*Decimal.fromJson("10")).toDouble();
    // case "VN": return "₫";
    // case "ID": return "Rp";
    // case "TH": return "฿";
    // case "RU": return "₽";
    // case "PH": return "₱";
      default: return coins.toString().toDou();
    }
  }catch(e){
    return coins.toString().toDou();
  }
}

List<CashTypeBean> getCashTypeList(){
  List<CashTypeBean> list=[];
  var code = Get.deviceLocale?.countryCode??"US";
  switch(code){
    case "BR":
      list.add(CashTypeBean(cashType: CashType.pix, icon: "pay_type8",bg: "pay_bg8"));
      list.add(CashTypeBean(cashType: CashType.pagBank, icon: "pay_type4",bg: "pay_bg4"));
      break;
  // case "VN": return "₫";
  // case "ID": return "Rp";
  // case "TH": return "฿";
  // case "RU": return "₽";
  // case "PH": return "₱";
    default:
      list.add(CashTypeBean(cashType: CashType.pay, icon: "pay_type1",bg: "pay_bg1"));
      list.add(CashTypeBean(cashType: CashType.cashApp, icon: "pay_type2",bg: "pay_bg2"));
      list.add(CashTypeBean(cashType: CashType.webMoney, icon: "pay_type3",bg: "pay_bg3"));
      list.add(CashTypeBean(cashType: CashType.pagBank, icon: "pay_type4",bg: "pay_bg4"));
      list.add(CashTypeBean(cashType: CashType.master, icon: "pay_type5",bg: "pay_bg5"));
      list.add(CashTypeBean(cashType: CashType.gp, icon: "pay_type6",bg: "pay_bg6"));
      list.add(CashTypeBean(cashType: CashType.amazon, icon: "pay_type7",bg: "pay_bg7"));
      break;
  }
  return list;
}


String getWheelImages(){
  var code = Get.deviceLocale?.countryCode??"US";
  switch(code){
    case "BR": return "wheel_baxi";
  // case "VN": return "₫";
  // case "ID": return "Rp";
  // case "TH": return "฿";
  // case "RU": return "₽";
  // case "PH": return "₱";
    default: return "wheel3";
  }
}