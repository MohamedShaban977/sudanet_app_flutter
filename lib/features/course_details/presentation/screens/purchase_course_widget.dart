import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/packages/quickalert/models/quickalert_type.dart';
import '../../../../core/packages/quickalert/widgets/quickalert_dialog.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/validation/validation.dart';
import '../../../../widgets/custom_button_with_loading.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../auth/login/presentation/manger/user_secure_storage.dart';
import '../../data/models/buy_course_request.dart';
import '../cubit/course_details_cubit.dart';

class PurchaseCourses {
  PurchaseCourses.show(BuildContext context,
      {required int courseId, bool isAlert = false}) {
    print(UserSecureStorage.getToken() != null);
    if (UserSecureStorage.getToken() != null) {
      _showPurchaseCourses(context, courseId: courseId, isAlert: isAlert);
    } else {
      _alertMustBeLogged(context);
    }
  }

  _showPurchaseCourses(BuildContext context,
      {required int courseId, bool isAlert = false}) {
    if (isAlert) {
      _buildShowAlertPurchaseCourses(context, courseId: courseId);
    } else {
      _buildShowBottomSheetPurchaseCourses(context, courseId: courseId);
    }
  }

  _alertMustBeLogged(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: 'Oops...',
      text: AppStrings.youMustBeLogged.tr(),
      borderRadius: AppSize.s8,
      widget: Column(children: [
        ElevatedButton(
            onPressed: () =>
                MagicRouterName.navigateAndPopAll(RoutesNames.loginRoute),
            child: Text(AppStrings.signIn.tr())),
        ElevatedButton(
            onPressed: () => MagicRouter.pop(),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: ColorManager.white,
              foregroundColor: ColorManager.secondary,
            ),
            child: Text(AppStrings.cancel.tr()))
      ]),
    );
  }

  _buildShowBottomSheetPurchaseCourses(BuildContext context,
      {required int courseId}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      // enableDrag: true,
      builder: (context) => SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: context.height * 0.38,
          child: ContentPurchaseCoursesWidget(
            courseId: courseId,
            isAlert: false,
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    );
  }

  _buildShowAlertPurchaseCourses(BuildContext context,
      {required int courseId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: SizedBox(
          height: context.height * 0.38,
          width: context.width,
          child: ContentPurchaseCoursesWidget(
            courseId: courseId,
            isAlert: true,
          ),
        ),
      ),
    );
  }
}

class ContentPurchaseCoursesWidget extends StatefulWidget {
  final int courseId;
  final bool isAlert;

  const ContentPurchaseCoursesWidget({
    super.key,
    required this.courseId,
    required this.isAlert,
  });

  @override
  State<ContentPurchaseCoursesWidget> createState() =>
      _ContentPurchaseCoursesWidgetState();
}

class _ContentPurchaseCoursesWidgetState
    extends State<ContentPurchaseCoursesWidget> {
  final TextEditingController _conCode = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _conCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 15.0, right: 25.0, left: 15.0, bottom: 15.0),
        child: Column(
          children: [
            /// Custom Divider
            if (!widget.isAlert)
              Container(
                height: 6.0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            if (!widget.isAlert) const SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.purchase.tr(),
                  style: context.displayLarge.copyWith(
                    color: ColorManager.primary,
                  ),
                ),
                if (widget.isAlert)
                  InkWell(
                    onTap: () => MagicRouter.pop(),
                    borderRadius: BorderRadius.circular(30.0),
                    splashColor: Colors.red.shade900.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.clear,
                        color: Colors.red.shade900,
                        size: 30.0,
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 30.0),

            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ادخل كود الشراء', style: context.titleLarge),
                    const SizedBox(height: AppSize.s12),
                    CustomTextFormField(
                      hint: 'مثال :xxxx-0000000000',
                      controller: _conCode,
                      validator: (value) => Validator.isValidCode(value!),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),

            /// SaveButton
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      elevation: 0.0,
                      fixedSize: const Size.fromHeight(50.0),
                      foregroundColor: ColorManager.primary),
                  onPressed: () => MagicRouter.pop(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(AppStrings.cancel.tr()),
                  ),
                ),
                const SizedBox(width: 40.0),
                CustomButtonWithLoading(
                  width: context.width * 0.35,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      await sl<CourseDetailsCubit>().buyCourse(BuyCourseRequest(
                        courseCode: _conCode.text,
                        courseId: '${widget.courseId}',
                      ));
                    }
                  },
                  text: AppStrings.purchase.tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
