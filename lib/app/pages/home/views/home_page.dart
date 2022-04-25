import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/components/item_run.dart';
import 'package:jogingu_advanced/app/pages/home/bloc/home_bloc.dart';
import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

import '../../../../domain/entities/run.dart';

class HomePage extends PageBase<HomeBloc> {
  late Size size;
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
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
                return Center(
                  child: Text(
                    "No run to show",
                    style: AppStyles.h4.copyWith(color: Colors.black),
                  ),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
				primary: false,
				physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ItemRun(
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
              buildItemBottomSheet(
                "Delete",
                "Delete this run",
                const Icon(Icons.delete_forever_rounded),
                () {
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

  Widget buildItemBottomSheet(
    String title,
    String subtitle,
    Icon tralling,
    VoidCallback onTap,
  ) {
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
      trailing: tralling,
      onTap: onTap,
    );
  }
}
