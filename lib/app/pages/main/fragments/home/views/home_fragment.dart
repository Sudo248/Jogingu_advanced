import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/base_fragment.dart';
import 'package:jogingu_advanced/app/components/item_run.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';
import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

import '../../../../../../domain/entities/run.dart';
import '../bloc/home_bloc.dart';

class HomeFragment extends BaseFragment<HomeBloc> {
  late final Size size;
  HomeFragment({Key? key}) : super(key: key, name: AppRoutes.home) {
    size = bloc.globalData.size;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Status<List<Run>>>(
        stream: bloc.runsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          return snapshot.data!.when<Widget>(
            onIdle: () => const SizedBox.shrink(),
            onLoading: () => const Center(
              child: SizedBox.square(
                dimension: 50,
                child: CircularProgressIndicator(),
              ),
            ),
            onSuccess: (data) {
              if (data.isEmpty) {
                return SizedBox(
                  height: size.height * 0.8,
                  width: size.width,
                  child: Center(
                    child: Text(
                      "No run to show",
                      style: AppStyles.h3.copyWith(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                primary: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ItemRun(
                  avatar: bloc.avatar,
                  username: bloc.username,
                  height: size.height * 0.5,
                  run: data[index],
                  onMenuClick: (key) {
                    showBottomSheet(context, key);
                  },
                ),
              );
            },
            onError: (error) {
              return Center(
                child: Text(error.message),
              );
            },
          );
        });
  }

  void showBottomSheet(BuildContext context, int key) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (_) {
        return SizedBox(
          height: size.height * 0.2,
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  "Menu options",
                  style: AppStyles.h4.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              ItemBottomSheet(
                title: "Delete",
                subtitle: "Delete this run",
                trailing: const Icon(Icons.delete_forever_rounded),
                onTap: () {
                  bloc.navigator.back();
                  showDialogConfirmDeleteItemRun(context, key);
                },
              )
            ],
          ),
        );
      },
    );
  }

  void showDialogConfirmDeleteItemRun(BuildContext context, dynamic key) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Center(
          child: Text(
            "Delete Run",
            style: AppStyles.h4.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        content: SizedBox(
          width: size.width * 0.85,
          child: Text(
            "Delete this run from Jogingu?",
            maxLines: 3,
            style: AppStyles.h5.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              bloc.navigator.back();
            },
            child: const Text(
              "Cancel",
            ),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              bloc.deleteRun(key);
            },
          ),
        ],
      ),
    );
  }
}

class ItemBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon trailing;
  final VoidCallback onTap;

  const ItemBottomSheet({Key? key, required this.title, required this.subtitle, required this.trailing, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
	  return ListTile(
    title: Text(
      title,
      style: AppStyles.h5.copyWith(
        color: Colors.black,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: AppStyles.h6.copyWith(
        color: Colors.black,
      ),
    ),
    trailing: trailing,
    onTap: onTap,
  );
  }
}
