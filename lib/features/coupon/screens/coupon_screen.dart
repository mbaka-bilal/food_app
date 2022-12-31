import 'package:flutter/material.dart';
import 'package:food_app/services/f_coupon.dart';
import 'package:provider/provider.dart';

import '../../../helpers/request_status.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/status_screen.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: FCoupon().fetchCoupon(),
          builder: (context,snapShot) {
              if (snapShot.hasError) {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                        const StatusScreen(
                            status:
                            Status.failure,
                            headerText:
                            "Unknown Error",
                            subText: "Error")));
              }

              if (snapShot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = snapShot.data!.docs;

              //

              // print ("the data is ${info['0'][0]}");

              // return Container();

              // data.forEach((element) {
              //   var data = element.data() as Map<String,dynamic>;
              //
              //   data.entries.map((e) => Container());
              // });



              return ListView.separated(itemBuilder: (context,index) {
                var info = data[index].data() as Map<String,dynamic>;

                return InkWell(
                  onTap: () {
                    context.read<FCoupon>().updateChosenIndex(index);
                    // print ("runtime type is ${info['0'][1].runtimeType}");
                    context.read<FCoupon>().updateDiscount(info['0'][1]);
                  },
                  child: Consumer<FCoupon>(
                    builder: (context,fCouponProvider,_) => Card(
                      color: (fCouponProvider.fetchChosenIndex() == index) ? Colors.blue : AppColors.grey,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:  200,
                                child: Text("${info['0'][0]}",style: TextStyles.semiBold(18,AppColors.black),)),
                            const Spacer(),
                            Text("${info['0'][1]}% off",style: TextStyles.normal(18,AppColors.black),),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }, separatorBuilder: (context,index) {
                return const SizedBox(
                  height: 10,
                );
              }, itemCount: data.length);


          }
        ),
      ),
    );
  }
}
