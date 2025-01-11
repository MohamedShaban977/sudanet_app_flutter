import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/assets_manager.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/service/open_url_launcher.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../cubit/contact_info_cubit.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: AppSize.s5,
      centerTitle: false,
      backgroundColor: ColorManager.background,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      title: Text(AppStrings.help.tr(),
          style: context.displayLarge.copyWith(
              color: ColorManager.textGray, fontWeight: FontWeight.w700)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<ContactInfoCubit, ContactInfoState>(
        listener: (context, state) {
          // if (state is GetContactInfoSuccessState) {
          //   contactInfo = state.response.data!;
          // }
        },
        builder: (context, state) {
          final cubit = sl<ContactInfoCubit>().get(context);

          if (state is GetContactInfoLoadingState) {
            return const CustomLoadingScreen();
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(ImageAssets.homeBanner3),
                const SizedBox(height: 40.0),
                Text(
                  'معلومات عنا',
                  style:
                      context.bodyLarge.copyWith(color: ColorManager.primary),
                ),
                const SizedBox(height: 20.0),
                Text(
                  cubit.contactInfo.about,
                  style: context.titleLarge,
                ),
                const SizedBox(height: 40.0),
                Text(
                  'سياسة الخصوصيه',
                  style:
                      context.bodyLarge.copyWith(color: ColorManager.primary),
                ),
                const SizedBox(height: 20.0),
                Text(
                  cubit.contactInfo.terms,
                  style: context.titleLarge,
                ),
                SizedBox(
                    width: context.width * 0.9,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.squarePhoneFlip,
                                  size: 35.0,
                                  color: ColorManager.primary,
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'رقم التلفون 1',
                                          style: context.bodyMedium.copyWith(
                                              color: ColorManager.primary,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          cubit.contactInfo.phone1,
                                          style: context.titleLarge,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            const Divider(
                                height: 40.0,
                                thickness: 1.5,
                                endIndent: 20.0,
                                indent: 20.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.squarePhoneFlip,
                                  size: 35.0,
                                  color: ColorManager.primary,
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'رقم التلفون 2',
                                          style: context.bodyMedium.copyWith(
                                              color: ColorManager.primary,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          cubit.contactInfo.phone1,
                                          style: context.titleLarge,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            const Divider(
                                height: 40.0,
                                thickness: 1.5,
                                endIndent: 20.0,
                                indent: 20.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.squareEnvelope,
                                  size: 35.0,
                                  color: ColorManager.primary,
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'البريد الالكترونى 1',
                                          style: context.bodyMedium.copyWith(
                                              color: ColorManager.primary,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          cubit.contactInfo.mail1,
                                          style: context.titleLarge,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            const Divider(
                                height: 40.0,
                                thickness: 1.5,
                                endIndent: 20.0,
                                indent: 20.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.squareEnvelope,
                                  size: 35.0,
                                  color: ColorManager.primary,
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'البريد الالكترونى 2',
                                          style: context.bodyMedium.copyWith(
                                              color: ColorManager.primary,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          cubit.contactInfo.mail2,
                                          style: context.titleLarge,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                    width: context.width * 0.9,
                    height: 100.0,
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10.0),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.spaceAround,
                          runSpacing: 20.0,
                          runAlignment: WrapAlignment.center,
                          direction: Axis.horizontal,
                          spacing: 10.0,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () => OpenUrlLauncher.launchLink(
                                  url: cubit.contactInfo.facebookLink),
                              child: const Icon(
                                FontAwesomeIcons.squareFacebook,
                                color: Colors.blueAccent,
                                size: 50.0,
                              ),
                            ),
                            InkWell(
                              onTap: () => OpenUrlLauncher.launchLink(
                                  url: cubit.contactInfo.twitterLink),
                              child: const Icon(
                                FontAwesomeIcons.squareTwitter,
                                color: Colors.blueAccent,
                                size: 50.0,
                              ),
                            ),
                            InkWell(
                              onTap: () => OpenUrlLauncher.launchLink(
                                  url: cubit.contactInfo.instegramLink),
                              child: const Icon(
                                FontAwesomeIcons.squareInstagram,
                                color: Colors.purple,
                                size: 50.0,
                              ),
                            ),
                            InkWell(
                              onTap: () => OpenUrlLauncher.launchLink(
                                  url: cubit.contactInfo.youtubeLink),
                              child: const Icon(
                                FontAwesomeIcons.squareYoutube,
                                color: Colors.red,
                                size: 50.0,
                              ),
                            ),
                            InkWell(
                              onTap: () => OpenUrlLauncher.launchWhatsApp(
                                  phone: cubit.contactInfo.whatsapp1),
                              child: const Icon(
                                FontAwesomeIcons.squareWhatsapp,
                                color: Colors.green,
                                size: 50.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
