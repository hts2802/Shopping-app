import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName= TextEditingController();
  final TextEditingController _contactPersonNumber= TextEditingController();
  late bool _islogged;
final CameraPosition _cameraPosition = CameraPosition(target: LatLng(
    43.77142857143, -122.677433
), zoom: 17);
late LatLng _initialPosition;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
