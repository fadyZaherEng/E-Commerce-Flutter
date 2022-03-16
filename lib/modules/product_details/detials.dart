// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/layout/home_provider.dart';
import 'package:flutter_technical_task/models/cart_model.dart';
import 'package:flutter_technical_task/models/products_model.dart';
import 'package:flutter_technical_task/shared/components/components.dart';
import 'package:flutter_technical_task/shared/network/local/cashe_helper.dart';
import 'package:flutter_technical_task/utils/ar.dart';
import 'package:flutter_technical_task/utils/en.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  ProductsModel productsModel;

  var quantityController = TextEditingController();

  ProductDetails(this.productsModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SharedHelper.get(key: 'lang') == 'en'
            ? en['product_Details']!
            : ar['product_Details']!),
        actions: [
          IconButton(
            onPressed: () {
              CartModel cart = CartModel(
                  date: DateTime.now().toString(),
                  userId: FirebaseAuth.instance.currentUser!.uid.toString(),
                  products: Products(
                      productId: productsModel.id,
                      quantity: int.parse(quantityController.text)));
              Provider.of<HomeProvider>(context, listen: false)
                  .addToCart(cart, productsModel.id, false);
            },
            icon: const Icon(Icons.add_shopping_cart),
          ),
          IconButton(
            onPressed: () {
              CartModel cart = CartModel(
                  date: DateTime.now().toString(),
                  userId: FirebaseAuth.instance.currentUser!.uid.toString(),
                  products: Products(
                      productId: productsModel.id,
                      quantity: int.parse(quantityController.text)));
              Provider.of<HomeProvider>(context, listen: false)
                  .addToCart(cart, productsModel.id, true);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(productsModel.image.toString()),
                width: double.infinity,
                height: 300,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  productsModel.title!,
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  '${productsModel.price!.toString()} \$',
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                productsModel.description.toString(),
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: defaultTextForm(
                  context: context,
                  Controller: quantityController,
                  prefixIcon: const Icon(Icons.production_quantity_limits),
                  text: SharedHelper.get(key: 'lang') == 'en' ? en['Quantity']! : ar['Quantity']!,
                  validate: (val) {
                    if (val.isEmpty) {
                      return 'Please Enter Quantity';
                    }
                    return null;
                  },
                  onSubmitted: () {},
                  type: TextInputType.number,
                  key: 'quantity',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
