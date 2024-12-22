import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/utils/size_config.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/features/dashboard/presentation/bloc/dash_bloc.dart';
import 'package:click_to_food/shared/common_widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/common_widgets/common_toast.dart';
import '../bloc/dash_event.dart';
import '../bloc/dash_state.dart';

class DashboardCategories extends StatefulWidget {
  const DashboardCategories({super.key});

  @override
  State createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardCategories> {
  // late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController();
    // Trigger StartScrolling event when the page loads
    context.read<DashBloc>().add(StartScrolling(context));
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => DashBloc()..add(StartScrolling(context)),
      child: BlocBuilder<DashBloc, DashState>(
          builder: (context, state) {
            final bloc = context.read<DashBloc>();

            return SizedBox(
              height: getProportionateScreenHeight(150),
              child: ListView.builder(
                  controller: bloc.scrollController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: kDefaultPadding),
                  itemCount: 25,
                  itemBuilder: (context, index) {

                    return SizedBox(
                      width: 130,
                      child: InkWell(
                        onTap: () {
                          CommonToast.showSuccessToast("Coming soon..");
                        },
                        child: Card(
                          color: ColorConfig.primaryColor.withOpacity(0.90),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          shadowColor: ColorConfig.primaryColor,
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: ColorConfig.whiteColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(Icons.emoji_food_beverage_rounded, size: 25, color: ColorConfig.primaryColor),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Gap(10),
                                    Text("Cat #${index + 1}", style: textSize16w500.copyWith(color: ColorConfig.whiteColor)),
                                    const Gap(5),
                                    Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: ColorConfig.whiteColor,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: const Icon(Icons.chevron_right_rounded, size: 18, color: ColorConfig.primaryColor)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
      ),
    );
  }
}

