import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:e_commerce/core/constant/imageassets.dart';

class Handlingdataview extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  const Handlingdataview({super.key, required this.statusrequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    if (statusrequest == Statusrequest.loading) {
      return Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImageassets.registerscreen, // نفس الخلفية اللي في main
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Lottie.asset(AppImageassets.loading, width: 150),
          ),
        ],
      );
    } else if (statusrequest == Statusrequest.offlinefailure) {
      return Center(child: Lottie.asset(AppImageassets.offline, width: 150));
    } else if (statusrequest == Statusrequest.serverfailure || statusrequest == Statusrequest.failure) {
      return Center(child: Lottie.asset(AppImageassets.server, width: 150));
    } else if (statusrequest == Statusrequest.none) {
      return Center(child: Lottie.asset(AppImageassets.nodata, width: 150));
    } else {
      return widget;
    }
  }
}

class HandlingDataRequest extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;

  const HandlingDataRequest({super.key, required this.statusrequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    switch (statusrequest) {
      case Statusrequest.loading:
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImageassets.registerscreen,
                fit: BoxFit.cover,
              ),
            ),
            Center(child: Lottie.asset(AppImageassets.loading, width: 150)),
          ],
        );
      case Statusrequest.offlinefailure:
        return Center(child: Lottie.asset(AppImageassets.offline, width: 150));
      case Statusrequest.serverfailure:
        return Center(child: Lottie.asset(AppImageassets.server, width: 150));
      case Statusrequest.serverException:
        return const Center(child: Text("Server error occurred", style: TextStyle(color: Colors.red)));
      default:
        return widget;
    }
  }
}














//the old is : 





//  import 'package:e_commerce/core/class/statusrequest.dart';
// import 'package:e_commerce/core/constant/imageassets.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class Handlingdataview extends StatelessWidget {
//   final Statusrequest statusrequest;
//   final Widget widget;
//   const Handlingdataview(
//       {super.key, required this.statusrequest, required this.widget});

//   @override
//   Widget build(BuildContext context) {
//     return statusrequest == Statusrequest.loading
//         ? Center(child: Lottie.asset(AppImageassets.loading, width: 150)
//             //   child: Text("loading..."),

//             )
//         : statusrequest == Statusrequest.offlinefailure
//             ? Center(
//                 child: Lottie.asset(AppImageassets.offline, width: 150),
//               )
//             : statusrequest == Statusrequest.serverfailure
//                 ? Center(
//                     child: Lottie.asset(AppImageassets.server, width: 150),
//                   )
//                 : statusrequest == Statusrequest.failure
//                     ? Center(
//                         child: Lottie.asset(AppImageassets.server, width: 150),
//                       )
//                     :statusrequest == Statusrequest.none
//                     ? Center(
//                         child: Lottie.asset(AppImageassets.nodata, width: 150),
//                       )
//                     :
                    
                    
//                      widget;
//   }
// }





// class HandlingDataRequest extends StatelessWidget {
//   final Statusrequest statusrequest;
//   final Widget widget;

//   const HandlingDataRequest({
//     super.key,
//     required this.statusrequest,
//     required this.widget,
//   });

//   @override
//   Widget build(BuildContext context) {
//     switch (statusrequest) {
     
//       // case Statusrequest.none:
//       //   return Center(child: Lottie.asset(AppImageassets.nodata, width: 150));
//       case Statusrequest.loading:
//         return Center(child: Lottie.asset(AppImageassets.loading, width: 150));
//       case Statusrequest.offlinefailure:
//         return Center(child: Lottie.asset(AppImageassets.offline, width: 150));
//       case Statusrequest.serverfailure:
//         return Center(child: Lottie.asset(AppImageassets.server, width: 150));
//       case Statusrequest.serverException:
//         return const Center(child: Text("Server error occurred", style: TextStyle(color: Colors.red)));
//       default:
//         return widget;
//     }
//   }
// } 