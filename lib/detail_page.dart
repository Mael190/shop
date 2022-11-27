import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'cart_model.dart';
import 'product_model.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  const DetailPage(this.product,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.nom),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              //alignment: Alignment.center,
              height: 180,
              child: Hero(
                  tag: product.nom,
                  child: Image.network(product.image)
              ),
            ),
            Text(product.nom,style: Theme.of(context).textTheme.headline6,),
            RatingBar.builder(
              initialRating: product.rating["rate"],
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                product.rating["rate"] = ((product.rating["rate"] * product.rating["count"] + rating) / (product.rating["count"] + 1));
                product.rating["count"] += 1;
              },
            ),
            Text("Nombre de vote(s) : ${product.rating["count"]}",style: Theme.of(context).textTheme.bodyLarge),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Description",style: Theme.of(context).textTheme.headline5,),
            ),
            Text(product.description,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.afficherPrixEnEuros(),
                  style: Theme.of(context).textTheme.headline4
                      ?.copyWith(color: Colors.black),),
                  ElevatedButton(
                    onPressed: (){
                      context.read<CartModel>().add(product);
                      },
                    child: Text("Ajouter".toUpperCase()),)
              ],),
            ),
          ],
        ),
      ),
    );
  }
}