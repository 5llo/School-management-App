// statusrequest = handlingData(response) ;
import 'package:e_commerce/core/class/statusrequest.dart';

Statusrequest handlingData(response) {
  if (response == null) {
    return Statusrequest.serverfailure;
  }

  if (response is Map) {
    if (response.containsKey('status')) {
      if (response['status'] == 'failure') {
        return Statusrequest.failure; // ✅ Correctly handling failure responses
      }
      if (response['status'] == 'success') {
        return Statusrequest.success;
      }
    }
  }

  return Statusrequest.failure; // ✅ Default failure, not serverfailure
}
