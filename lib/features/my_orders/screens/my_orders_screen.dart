import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/services/f_database.dart';

import '../../../helpers/request_status.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/status_screen.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: (() => Navigator.of(context).pop()),
            child: const Icon(
              Icons.cancel,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: FDatabase.fetchOrders(),
          builder: ((context, asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const StatusScreen(
                      status: Status.failure,
                      headerText: "Unknown Error",
                      subText: "Error")));
            }

            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            // print("the data is ${}");

            return ListView.builder(
              itemCount: asyncSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = asyncSnapshot.data!.docs[index]
                    .data() as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            OrderInformation(foodIds: data['orders'])));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    color: AppColors.alabaster,
                    child: Text(
                      data['date'].toDate().toString().substring(0, 16),
                      style: TextStyles.semiBold(20, AppColors.black),
                    ),
                  ),
                );
              },
            );
          }),
        ));
  }
}

class OrderInformation extends StatelessWidget {
  const OrderInformation({super.key, required this.foodIds});

  final List<dynamic> foodIds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return FutureBuilder(
                future: FDatabase.fetchSingleFoodInformation(foodIds[index]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        snapshot.data as Map<String, dynamic>;
                    // print('the data is $data');
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      color: AppColors.grey,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: data['image_url'],
                                fit: BoxFit.fitHeight,
                                placeholder: (context, count) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['name'],
                                  style: TextStyles.normal(
                                    15,
                                    AppColors.black,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(data['cost'].toString(),
                                  style: TextStyles.semiBold(
                                    20,
                                    AppColors.black,
                                  ))
                            ],
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    );
                  }
                });
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: foodIds.length),
    );
  }
}
