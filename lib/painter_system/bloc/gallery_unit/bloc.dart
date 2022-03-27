import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryUnitBloc extends Cubit<String>{
  GalleryUnitBloc() : super('');

  void loadGalleryInfo() async{
    String result = await rootBundle.loadString('assets/data/gallery_info.json');
    emit(result);
  }
}