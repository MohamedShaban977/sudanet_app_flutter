import 'package:flutter_bloc/flutter_bloc.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  SliderCubit get(context) => BlocProvider.of(context);

  List<String> imageSlider() {
    return [];
  }

  int yourActiveIndex = 0;

  onPageChanged(int index) {
    yourActiveIndex = index;
    emit(ChangeSliderState());
  }
}
