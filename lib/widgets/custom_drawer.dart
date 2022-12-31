import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/f_auth.dart';
import '../services/f_database.dart';
import '../utils/appstyles.dart';

import '../../../features/my_orders/screens/my_orders_screen.dart';
import '../../../features/wallet/screens/my_wallet_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget drawerItem(String title, IconData icon, Function function) {
      return GestureDetector(
        onTap: () {
          function();
        },
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              size: 30,
              color: AppColors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyles.normal(14, AppColors.grey),
            ),
          ],
        ),
      );
    }

    return Drawer(
      backgroundColor: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(color: AppColors.green),
                child: StreamBuilder(
                    stream: FDatabase.userInfoStream(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        DocumentSnapshot documentSnapshot =
                            snapShot.data as DocumentSnapshot;
                        Map<String, dynamic> data =
                            documentSnapshot.data() as Map<String, dynamic>;

                        return Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.white,
                                  child: Text(
                                    data['name'][0].toUpperCase(),
                                    style: TextStyles.semiBold(
                                        50, AppColors.black),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'].toUpperCase(),
                                      style: TextStyles.normal(
                                          14, AppColors.white),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        FirebaseAuth
                                            .instance.currentUser!.email!,
                                        style: TextStyles.normal(
                                            14, AppColors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        FaIcon(FontAwesomeIcons.nairaSign,
                                            color: Colors.white, size: 12),
                                        Text(
                                          ' ${data['balance']}',
                                          style: TextStyles.normal(
                                              14, AppColors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                      } else {
                        return const Center(
                          child: LinearProgressIndicator(),
                        );
                      }
                    })),
            const SizedBox(
              height: 10,
            ),
            drawerItem('Home', Icons.home, () {
              Navigator.of(context).pop();
            }),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerItem('My Profile', Icons.person, () {}),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerItem('My Orders', Icons.shopping_cart, () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => const MyOrders())));
            }),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerItem('My Wallet', Icons.wallet, () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyWallet()));
            }),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerItem('My Address', Icons.pin_drop, () {}),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerItem('Contact us', Icons.phone, () {}),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerItem('Feedback', Icons.message, () {}),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerItem('Refer & Earn', Icons.messenger_sharp, () {}),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerItem('Share', Icons.share, () {}),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerItem('Logout', Icons.logout, () {
              FAuth().logOut(context);
            }),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
