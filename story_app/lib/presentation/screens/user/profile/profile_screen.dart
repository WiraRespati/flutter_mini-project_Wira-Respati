import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/bloc/user/profile/profile_bloc.dart';
import 'package:story_app/presentation/bloc/user/profile/profile_state.dart';
import 'package:story_app/presentation/screens/user/profile/button_profile_widget.dart';
import '../../../../utils/constant/color_constant.dart';
import '../../../../utils/constant/name_routes.dart';
import '../../../bloc/story/detail/detail_story_state.dart';
import '../../../bloc/user/auth/auth_bloc.dart';
import '../../../bloc/user/auth/auth_event.dart';
import '../../../bloc/user/auth/auth_state.dart';
import '../../../bloc/user/profile/profile_event.dart';
import '../../../widgets/show_dialog_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<ProfileBloc>(context).add(ProfileButtonPressed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileSuccess) {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Text(user.name),
                  const Icon(Icons.arrow_drop_down_outlined),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 60,
                          child: Column(
                            children: [
                              BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state is AuthLogoutSuccess) {
                                    Navigator.pushReplacementNamed(
                                        context, NameRoutes.initRoute);
                                  } else if (state is AuthFailure) {
                                    ShowDialogWidget.showErrorDialog(
                                      context: context,
                                      title: 'Login Failed',
                                      message: state.error,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AuthLoading) {
                                    return const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    );
                                  } else {
                                    return ListTile(
                                      leading: const Icon(Icons.exit_to_app),
                                      title: const Text('Log Out'),
                                      onTap: () {
                                        context
                                            .read<AuthBloc>()
                                            .add(AuthButtonPressed());
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: CircleAvatar(
                            backgroundColor: ColorConstant.onPrimaryColor,
                            radius: 36,
                            child: Text(user.name[0].toUpperCase()),
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 16, left: 8),
                          child: Column(
                            children: [
                              Text('0'),
                              Text('posts'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Text('0'),
                              Text('followers'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Text('0'),
                              Text('following'),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.email),
                          const SizedBox(
                            width: 210,
                            child: Text(
                              '"Born too late to explore earth, Born too early to explore the stars"',
                              maxLines: null,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonProfile(
                      widget: const Text('Edit Profile'),
                      width: 150,
                      height: 30,
                      onTap: () {
                        ShowDialogWidget.showErrorDialog(
                          title: 'Coming Soon',
                          message: 'This feature is not available yet',
                          context: context,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    ButtonProfile(
                      widget: const Text('Share Profile'),
                      width: 150,
                      height: 30,
                      onTap: () {
                        ShowDialogWidget.showErrorDialog(
                          title: 'Coming Soon',
                          message: 'This feature is not available yet',
                          context: context,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    ButtonProfile(
                      widget: const Icon(Icons.person_add_outlined),
                      width: 30,
                      height: 30,
                      onTap: () {
                        ShowDialogWidget.showErrorDialog(
                          title: 'Coming Soon',
                          message: 'This feature is not available yet',
                          context: context,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DefaultTabController(
                  length: 3,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: ColorConstant.primaryColor,
                    tabs: [
                      Tab(
                        icon: IconButton(
                          icon: Icon(
                            Icons.grid_on,
                            color: ColorConstant.primaryColor,
                          ),
                          onPressed: () {
                            ShowDialogWidget.showErrorDialog(
                              title: 'Coming Soon',
                              message: 'This feature is not available yet',
                              context: context,
                            );
                          },
                        ),
                      ),
                      Tab(
                        icon: IconButton(
                          icon: Icon(
                            Icons.live_tv,
                            color: ColorConstant.primaryColor,
                          ),
                          onPressed: () {
                            ShowDialogWidget.showErrorDialog(
                              title: 'Coming Soon',
                              message: 'This feature is not available yet',
                              context: context,
                            );
                          },
                        ),
                      ),
                      Tab(
                        icon: IconButton(
                          icon: Icon(
                            Icons.assignment_ind_outlined,
                            color: ColorConstant.primaryColor,
                          ),
                          onPressed: () {
                            ShowDialogWidget.showErrorDialog(
                              title: 'Coming Soon',
                              message: 'This feature is not available yet',
                              context: context,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 96),
                const Text("Coming soon...")
              ],
            ),
          );
        } else if (state is DetailStoryFailure) {
          return const Center(
            child: Text('Failed to load profile'),
          );
        } else {
          return const Text('Unknown error');
        }
      },
    );
  }
}
