import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogingu_advanced/app/base/base_page.dart';
import 'package:jogingu_advanced/app/components/button.dart';
import 'package:jogingu_advanced/app/components/edit_text.dart';
import 'package:jogingu_advanced/app/components/edit_text_form_field.dart';
import 'package:jogingu_advanced/app/pages/profile/bloc/profile_bloc.dart';
import 'package:jogingu_advanced/app/utils/dialog.dart';
import 'package:jogingu_advanced/domain/entities/gender.dart';
import 'package:jogingu_advanced/resources/app_assets.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

import '../../../components/dropdown_text_form_field.dart';

class ProfilePage extends BasePage<ProfileBloc> {
  final String? argument;
  ProfilePage({Key? key, required this.argument}) : super(key: key);

  @override
  void onInit() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      );
    });
    if (argument == "prepareToRun") {
      bloc.prepareToRun = true;
    }
    super.onInit();
  }

  @override
  void onDispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColorDark,
      ),
    );
    super.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (await canBack(context)) {
            bloc.navigator.back(false);
          }
          return Future.value(false);
        },
        child: CustomScrollView(
          slivers: [
            ProfileAppBar(
                bloc: bloc,
                onBack: () async {
                  if (await canBack(context)) {
                    bloc.navigator.back(false);
                  }
                }),
            ProfileSliverToBoxAdapter(bloc: bloc),
          ],
        ),
      ),
    );
  }

  Future<bool> canBack(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (bloc.user == null && bloc.prepareToRun) {
      bloc.onSaveUser();
      return Future.value(false);
    }
    if (bloc.onChange) {
      showJoginguConfirmDialog(
        context,
        title: const FittedBox(
          child: Text("Do you want save"),
        ),
        content: const Text("Please save change before back."),
        onNegative: () {
          bloc.navigator.back<bool>(false);
        },
        onPositive: () {
          bloc.onSaveUser();
        },
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class ProfileAppBar extends StatelessWidget {
  final ProfileBloc bloc;
  final VoidCallback onBack;
  const ProfileAppBar({
    Key? key,
    required this.bloc,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primaryColor,
      expandedHeight: bloc.globalData.height * 0.3,
      pinned: true,
      stretch: true,
      leading: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: onBack,
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      actions: [
        PopupMenuButton<int>(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.image),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Open galley"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.camera_alt_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Take photo"),
                  ],
                ),
              )
            ];
          },
          onSelected: (selected) {
            bloc.pickImage(selected);
          },
        )
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.biggest.height;
          return FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                StreamBuilder<String?>(
                    stream: bloc.avatarUrl.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      }
                      if (snapshot.data == null || !snapshot.data!.endsWith(".png")) {
                        return Image.asset(
                          AppAssets.avatar,
                          fit: BoxFit.cover,
                        );
                      }
                      return Image.file(
                        bloc.avatar!,
                        fit: BoxFit.cover,
                      );
                    }),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                        ]),
                  ),
                ),
              ],
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: height <= 90.0,
                  child: StreamBuilder<String?>(
                      stream: bloc.avatarUrl.stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        if (snapshot.data == null ||
                            !snapshot.data!.endsWith(".png")) {
                          return const CircleAvatar(
                            backgroundImage: AssetImage(
                              AppAssets.avatar,
                            ),
                          );
                        }
                        return CircleAvatar(
                          backgroundImage: FileImage(
                            bloc.avatar!,
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Profile",
                  style: AppStyles.h4.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileSliverToBoxAdapter extends StatelessWidget {
  final ProfileBloc bloc;
  const ProfileSliverToBoxAdapter({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: EditText(
                    controller: bloc.firstNameCtrl,
                    labelText: "First Name",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: EditText(
                    controller: bloc.lastNameCtrl,
                    labelText: "Last Name",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: EditText(
                    controller: bloc.cityCtrl,
                    labelText: "City",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: EditText(
                    controller: bloc.countryCtrl,
                    labelText: "Country",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            EditText(
              controller: bloc.primarySportCtrl,
              labelText: "Primary Sport",
            ),
            const SizedBox(
              height: 15,
            ),
            EditTextFormField(
              formKey: bloc.birthdayFormKey,
              controller: bloc.birthdayCtrl,
              labelText: "Birthday *",
              suffix: const Icon(
                Icons.calendar_month_outlined,
                color: AppColors.primaryColor,
              ),
              readOnly: true,
              onTap: () async {
                final time = await showJoginguDatePicker(context);
                bloc.updateBirthday(time);
              },
              validator: bloc.birthdayValidator,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: EditTextFormField(
                    formKey: bloc.heightFormKey,
                    controller: bloc.heightCtrl,
                    labelText: "Height(cm)",
                    keyboardType: TextInputType.number,
                    validator: bloc.heightValidator,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: EditTextFormField(
                    formKey: bloc.weightFormKey,
                    controller: bloc.weightCtrl,
                    labelText: "Weight(kg)",
                    keyboardType: TextInputType.number,
                    validator: bloc.weightValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownTextFormField(
              formKey: bloc.genderFormKey,
              labelText: "Gender",
              items: Gender.values.map((e) => e.name).toList(),
              onChange: bloc.onChangeGender,
              controller: bloc.genderCtrl,
              validator: bloc.genderValidator,
            ),
            const SizedBox(
              height: 15,
            ),
            Button(
              primary: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
              onPressed: () {
                bloc.onSaveUser();
              },
              child: const Text(
                "Save",
                style: AppStyles.h4,
              ),
            ),
            SizedBox(
              height: bloc.globalData.height * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
