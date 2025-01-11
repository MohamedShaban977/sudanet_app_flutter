import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/service/open_url_launcher.dart';
import '../../domain/entities/slider_entity.dart';

class SliderWidget extends StatefulWidget {
  final List<SliderEntity> slidersItems;

  const SliderWidget({
    super.key,
    required this.slidersItems,
  });

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int yourActiveIndex = 0;

/*  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        final cubit = SliderCubit().get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: cubit.imageSlider().length,
                  itemBuilder: (_, itemIndex, i) => Image.asset(
                    cubit.imageSlider()[itemIndex],
                    fit: BoxFit.fill,
                  ),
                  options: CarouselOptions(
                    aspectRatio: 16 / 8,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    autoPlay: true,
                    onPageChanged: (index, c) {
                      cubit.onPageChanged(index);
                    },
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.linear,
                    // enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                // const SizedBox(height: AppSize.s18),
                Positioned(
                  bottom: 10.0,
                  child: AnimatedSmoothIndicator(
                    activeIndex: cubit.yourActiveIndex,
                    count: cubit.imageSlider().length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                      activeDotColor: ColorManager.secondary,
                      dotColor: Colors.white,
                    ),
                    // textDirection: context.isEnLocale
                    //     ? TextDirection.rtl
                    //     : TextDirection.ltr,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider.builder(
              itemCount:
                  widget.slidersItems.isEmpty ? 1 : widget.slidersItems.length,
              itemBuilder: (_, itemIndex, i) => GestureDetector(
                onTap: () {
                  OpenUrlLauncher.launchLink(
                      url: widget.slidersItems[itemIndex].link);
                },
                child: Image.network(
                  widget.slidersItems[itemIndex].imagePath.isNotEmpty
                      ? widget.slidersItems[itemIndex].imagePath
                      : "https://suda-net.com/Upload/23595242023101537PMscreencapture-localhost-59241-Client-Index-2023-05-25-07_37_33.png",
                  width: context.width,
                  fit: BoxFit.fill,
                  gaplessPlayback: true,
                ),
              ),
              options: CarouselOptions(
                aspectRatio: 16 / 6.5,
                viewportFraction: 1.0,
                initialPage: 0,
                autoPlay: true,
                onPageChanged: (index, c) {
                  setState(() => yourActiveIndex = index);
                },
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.linear,
                // enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
            // const SizedBox(height: AppSize.s18),
            Positioned(
              bottom: 10.0,
              child: AnimatedSmoothIndicator(
                activeIndex: yourActiveIndex,
                count: widget.slidersItems.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  activeDotColor: ColorManager.secondary,
                  dotColor: Colors.white,
                ),
                // textDirection: context.isEnLocale
                //     ? TextDirection.rtl
                //     : TextDirection.ltr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
