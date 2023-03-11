import 'package:decimal/decimal.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculation {
  Parser p = Parser();
  ContextModel cm = ContextModel();
  add(dynamic n1,dynamic n2){
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())+Decimal.parse(n2==null?"0.0":n2.toString())).toString());
  }
  add3(dynamic n1,dynamic n2,dynamic n3){
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())+
        Decimal.parse(n2==null?"0.0":n2.toString())+
        Decimal.parse(n3==null?"0.0":n3.toString())
    ).toString());
  }
  sub(dynamic n1,dynamic n2){
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())-Decimal.parse(n2==null?"0.0":n2.toString())).toString());
  }

  sub3(dynamic n1,dynamic n2,dynamic n3){
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())-
        Decimal.parse(n2==null?"0.0":n2.toString())-
        Decimal.parse(n3==null?"0.0":n3.toString())
    ).toString());
  }

  mul(dynamic n1,dynamic n2){
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())*Decimal.parse(n2==null?"0.0":n2.toString())).toString());
  }
  div(dynamic n1,dynamic n2){
    double x=double.parse(p.parse("$n1/$n2").evaluate(EvaluationType.REAL, cm).toString());
    return x;
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())/Decimal.parse(n2==null?"0.0":n2.toString())).toString());
  }


  taxAmount({dynamic taxValue, dynamic amount, dynamic discountAmount}){
    return double.parse(((Decimal.parse(taxValue==null?"0.0":taxValue.toString())*(Decimal.parse(amount==null?"0.0":amount.toString())-Decimal.parse(discountAmount==null?"0.0":discountAmount.toString())))/Decimal.parse("100")).toString());
  }

  discountAmount({dynamic discountValue, dynamic amount}){
   return double.parse(((Decimal.parse(discountValue==null?"0.0":discountValue.toString())*Decimal.parse(amount==null?"0.0":amount.toString()))/Decimal.parse("100")).toString());
  }

  totalAmount({dynamic amount, dynamic taxAmount, dynamic discountAmount}){
   return double.parse((Decimal.parse(amount==null?"0.0":amount.toString())+Decimal.parse(taxAmount==null?"0.0":taxAmount.toString())-Decimal.parse(discountAmount==null?"0.0":discountAmount.toString())).toString());
  }

  amountToDisPercentage({dynamic discountValue, dynamic subTotal}){
  //  return double.parse((((Decimal.parse(discountValue.toString())*Decimal.parse("100"))/Decimal.parse(subTotal.toString()))/Decimal.parse("100")).toString());
  }


  serviceAmount({dynamic serviceValue, dynamic subTotal}){
    return double.parse(((Decimal.parse(serviceValue==null?"0.0":serviceValue.toString())*Decimal.parse(subTotal==null?"0.0":subTotal.toString()))/Decimal.parse("100")).toString());
  }



  tax(dynamic taxValue,dynamic price,dynamic qty){

    return double.parse(((Decimal.parse(taxValue==null?"0.0":taxValue.toString()) *
        Decimal.parse(price==null?"0.0":price.toString()) * Decimal.parse(qty==null?"0.0":qty.toString()))/
        Decimal.parse("100")
    ).toString());
  }


}
