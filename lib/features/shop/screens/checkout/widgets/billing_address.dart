import 'package:fashion_star_shop/common/widgets/texts/section_heading.dart';
import 'package:fashion_star_shop/features/shop/models/address.dart';
import 'package:fashion_star_shop/features/personalization/model/user.dart';

import 'package:fashion_star_shop/services/variant_service.dart';
import 'package:flutter/material.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressSelection extends StatefulWidget {
  @override
  _AddressSelectionState createState() => _AddressSelectionState();
}

class _AddressSelectionState extends State<AddressSelection> {
  // Current selected address
  Address? currentAddress;
  List<Address> listAddress = [];
  User? user;
  String? userEmail;
  Future<void> getUserEmail() async {
    final SharedPreferences catDetails = await SharedPreferences.getInstance();
    final String? userEmailLogin = catDetails.getString('emailLogin');
    if (userEmailLogin != null) {
      var details = await CatManagementApi.findUserInfo(userEmailLogin);
      var resultAddress =
          await CatManagementApi.findAddressList(details!.id.toString());
      setState(() {
        userEmail = userEmailLogin;
        user = details;
        listAddress = resultAddress!;
      });
      if (listAddress.isNotEmpty) {
        setState(() {
          currentAddress = listAddress.first;
        });
      }
    }
  }

  void _changeAddress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select your Address'),
          content: SingleChildScrollView(
            child: ListBody(
              children: listAddress
                  .map((address) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentAddress = address;
                            Navigator.of(context).pop();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${address.city}, ${address.district}, ${address.ward}, ${address.street}'),
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TSectionHeading(
          title: 'Shipping Address',
          buttonTitle: currentAddress != null
              ? 'Find another'
              : (listAddress.isNotEmpty
                  ? 'Select your Address'
                  : 'Add new Address'),
          onPressed: _changeAddress,
        ),
        Text(
          userEmail.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: 8.0),
            Text(
              user!.phone.toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                '${currentAddress!.city}, ${currentAddress!.district}, ${currentAddress!.ward}, ${currentAddress!.street}',
                style: Theme.of(context).textTheme.bodyText2,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
