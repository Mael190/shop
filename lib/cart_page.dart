import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'product_model.dart';
import 'cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}
//2 classe pour avoir un state qui permet de supprimer le produit de la vue

class _CartPageState extends State<CartPage> {
  @override

  Widget build(BuildContext context) {
    CartModel cartModel = context.read<CartModel>();
    List<Product> cartProducts = context.watch<CartModel>().getProducts();

    return Scaffold(
      appBar: AppBar(title: Text("Panier EpsiShop")),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Votre panier contient ${cartProducts
                  .length} élément${cartProducts.length > 1 ? "s" : ""}",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) =>
                      ListTile(
                        onTap: () {
                          context.go("/detail", extra: cartProducts[index]);
                        },
                        title: Text(cartProducts[index].nom),
                        subtitle: Text(
                            cartProducts[index].afficherPrixEnEuros()),
                        leading: Hero(
                          tag: cartProducts[index].nom,
                          child: Image.network(
                            cartProducts[index].image,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        trailing: TextButton(
                          child: const Text("Supprimer"),
                          onPressed: () {
                            cartModel.remove(cartProducts[index]);
                          },
                        ),
                      ),
                ),
              ),
              Spacer(),
              Text('Votre panier total est de : ${cartModel.getTotalPrice()} €',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              )

            ],
          ),
        ),
      ),
    );
  }
}