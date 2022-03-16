
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/adaptive/components_adaptive.dart';
import 'package:flutter_technical_task/layout/home_provider.dart';
import 'package:flutter_technical_task/models/products_model.dart';
import 'package:flutter_technical_task/modules/product_details/detials.dart';
import 'package:flutter_technical_task/shared/components/components.dart';
import 'package:flutter_technical_task/shared/components/constants.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

class InterHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider
        .of<HomeProvider>(context, listen: true)
        .selectedCat != null
        ? Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Builder(builder: (context) {
            dynamic selItem =
                Provider
                    .of<HomeProvider>(context, listen: true)
                    .selectedCat;
            if (selItem != null) {
              context.read<HomeProvider>().getProducts(selItem);
            }
            return DropdownButton<String>(
              alignment: AlignmentDirectional.topCenter,
              isExpanded: true,
              elevation: 0,
              items: Provider
                  .of<HomeProvider>(context, listen: true)
                  .categories
                  .map((selectItem) {
                return DropdownMenuItem<String>(
                  value: selectItem,
                  child: Text(
                    selectItem!,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,
                  ),
                );
              }).toList(),
              onChanged: (val) {
                Provider.of<HomeProvider>(context, listen: false)
                    .changeCat(val!);
                Provider.of<HomeProvider>(context, listen: false)
                    .getProducts(val);
              },
              value: selItem,
            );
          }),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: Provider.of<HomeProvider>(context).getProducts(
                  Provider
                      .of<HomeProvider>(context, listen: true)
                      .selectedCat),
              builder: (ctx, snap) {
                if (snap.hasData) {
                  List<ProductsModel> products =
                  snap.data as List<ProductsModel>;
                  return ConditionalBuilder(
                    condition: products.isNotEmpty,
                    builder: (context) {
                      Provider.of<HomeProvider>(context, listen: false)
                          .getProducts(
                          context
                              .watch<HomeProvider>()
                              .selectedCat);
                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                buildItem(products[index], context),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 20,
                            ),
                            itemCount: products.length),
                      );
                    },
                    fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                  );
                }
                return const CircularProgressIndicator();
              }),
        ],
      ),
    )
        : AdaptiveIndicator(getOs());
  }

  buildItem(ProductsModel productsBasedCategories, context) {
    return InkWell(
      onTap: () {
        navigateToWithReturn(context, ProductDetails(productsBasedCategories));
      },
      child: StreamBuilder<String?>(
        stream: linkStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              Image(
                image: NetworkImage(productsBasedCategories.image.toString()),
                width: double.infinity,
                height: 200,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  productsBasedCategories.title!,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '${productsBasedCategories.price!.toString()} \$',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                      child: IconButton(
                        onPressed: (){
                           getInitialLink().then((value) {
                             String link=snapshot.data??value.toString();
                            print(link);
                            // showDialog(context: context, builder:(context)=>AlertDialog(
                            //       title: Text(value.toString(),style: Theme.of(context).textTheme.bodyText1,),
                            //     ));
                           }).catchError((onError){
                             print(onError.toString());
                           });
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Colors.pink,
                          size: 25,
                        ),
                      )),
                ],
              ),
            ],
          );
        }
      ),
    );
  }
}
