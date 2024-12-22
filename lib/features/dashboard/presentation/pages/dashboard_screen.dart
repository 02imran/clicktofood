import 'dart:async';

import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/utils/global_function.dart';
import 'package:click_to_food/core/utils/size_config.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/features/dashboard/presentation/bloc/dash_bloc.dart';
import 'package:click_to_food/features/dashboard/presentation/bloc/dash_state.dart';
import 'package:click_to_food/shared/common_widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../../shared/common_widgets/common_toast.dart';
import '../../../../shared/common_widgets/custom_app_bar.dart';
import '../../../../shared/common_widgets/drawer_menu.dart';
import '../../../../shared/common_widgets/primary_button.dart';
import '../bloc/dash_event.dart';
import '../widget/dashboard_categories.dart';
import '../widget/dashboard_profile.dart';
import '../widget/dashboard_recent_orders_list.dart';
import '../widget/search.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DashBloc()..add(StartTimer(context)),
      child: Scaffold(
        backgroundColor: ColorConfig.whiteColor,
        body: BlocBuilder<DashBloc, DashState>(
          builder: (context, state) {
            final bloc = context.read<DashBloc>();

            return StreamBuilder<int>(
              stream: bloc.timerStream,
              builder: (context, snapshot) {
                final remainingTime = snapshot.data ?? 0;

                return Center(
                  child: remainingTime > 0
                      ?
                  Column(
                    children: [

                      // Profile, Timer
                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Flexible(flex: 0, child: DashboardProfile()),

                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.only(right: 20, left: 10, top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Card(
                                    color: ColorConfig.primaryColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    shadowColor: ColorConfig.primaryColor,
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text("Token Refresh in:", style: TextStyle(fontSize: 12, color: ColorConfig.whiteColor)),
                                          Text(_formatTime(remainingTime),
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorConfig.whiteColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  state.isSubmitting ? const CircularProgressIndicator() : InkWell(
                                    onTap: () {
                                      CommonToast.showErrorToast("Logging you out..");
                                      bloc.add(Logout(context));
                                    },
                                    child: Card(
                                      color: ColorConfig.primaryColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      shadowColor: ColorConfig.primaryColor,
                                      elevation: 3,
                                      margin: const EdgeInsets.only(left: 5),
                                      child: const Padding(
                                        padding: EdgeInsets.all(kDefaultPadding),
                                        child: Icon(Icons.logout_rounded, color: ColorConfig.whiteColor, size: 24),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Search(),

                      const Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: kDefaultPadding, bottom: 15, top: 15),
                            child: Text("Categories", style: textSize18w600),
                          ),
                        ],
                      ),
                      const DashboardCategories(),

                      // Popular List
                      const Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: kDefaultPadding, bottom: 15, top: 0),
                            child: Text("Popular Foods", style: textSize18w600),
                          ),
                        ],
                      ),
                      const Expanded(child: DashboardRecentOrdersList()),

                    ],
                  )
                      :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Loading your setup",
                        style: TextStyle(fontSize: 24, color: Colors.red), textAlign: TextAlign.center,),
                      const Gap(30),
                      state.isSubmitting
                          ? const CircularProgressIndicator()
                          :
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: PrimaryButton(
                          btnText: "Refresh Token",
                          onPressed: () => bloc.add(RefreshToken(context)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    return [
      if (hours > 0) '${hours.toString().padLeft(2, '0')}h',
      if (minutes > 0 || hours > 0) '${minutes.toString().padLeft(2, '0')}m', // Show minutes if hours > 0
      '${seconds.toString().padLeft(2, '0')}s'
    ].join(':');
  }

}
