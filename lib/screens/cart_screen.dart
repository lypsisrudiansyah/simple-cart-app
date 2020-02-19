import 'package:flutter/material.dart';
import 'package:multi_provider_cart_app/shared/cart.dart';
import 'package:multi_provider_cart_app/shared/money.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Money>(create: (context) => Money()),
        ChangeNotifierProvider<Cart>(create: (context) => Cart())
      ],
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Consumer<Money>(
              builder: (context, money, _) => Consumer<Cart>(
                builder: (context, cart, _) => FloatingActionButton(
                  onPressed: () {
                    if (cart.quantity >= 1) {
                      cart.quantity -= 1;
                      money.balance += 1000;
                    }
                  },
                  child: Icon(Icons.remove),
                  backgroundColor: Colors.green[300],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Consumer<Money>(
              builder: (context, money, _) => Consumer<Cart>(
                builder: (context, cart, _) => FloatingActionButton(
                  onPressed: () {
                    if (money.balance >= 1000) {
                      cart.quantity += 1;
                      money.balance -= 1000;
                    }
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green[400],
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Learn Provider"),
          flexibleSpace: Container(
              decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/t.png'),
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeat),
          )),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /* Text(
                    "Balance",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                  ), */
                  Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Consumer<Money>(
                          builder: (context, money, _) => money.balance != 0 ? Text(
                              "Your Balance = " + money.balance.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700)) :
                              Text('Your balance is used up', style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700))
                        ),
                      ),
                      height: 30,
                      width: 200,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(25),
                           )),
                ],
              ),
              Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Consumer<Cart>(
                      builder: (context, cart, _) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 100,
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/gorengan.png'))),
                              SizedBox(width: 10),
                              Text(
                                  "Fried Food (1000) x " +
                                      cart.quantity.toString() +
                                      " = ",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ],
                          ),
                          Text((1000 * cart.quantity).toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  height: 80,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 2))),
            ],
          ),
        ),
      ),
    );
  }
}
