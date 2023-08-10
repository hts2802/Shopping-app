import 'package:doan/data/repository/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService{
LocationRepo locationRepo;
LocationController({required this.locationRepo});
bool _loading = false;
late Position _positon;
late Position _pickPosition;
Placemark _placemark = Placemark();
Placemark _pickPlacemark = Placemark();
List<AddressModel> _addressList=[];
late List<AddressModel> _allAddressList;
List<String> _addressTypeList=["home","office","others"];
int _addressTypeIndex=0;}
