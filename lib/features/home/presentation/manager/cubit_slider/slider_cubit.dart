import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_manage/assets_manager.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  SliderCubit get(context) => BlocProvider.of(context);

  List<String> imageSlider() {
    return [
      ImageAssets.homeBanner1,
      ImageAssets.homeBanner2,
      ImageAssets.homeBanner3,
      ImageAssets.homeBanner1,
      ImageAssets.homeBanner2,
      ImageAssets.homeBanner3,
    ];
  }

  int yourActiveIndex = 0;

  onPageChanged(int index) {
    yourActiveIndex = index;
    emit(ChangeSliderState());
  }
}
