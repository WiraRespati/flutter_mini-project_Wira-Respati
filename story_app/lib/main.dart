import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/data/datasources/story/detail/detail_story_remote_data_source.dart';
import 'package:story_app/data/datasources/story/list/list_story_remote_data_source.dart';
import 'package:story_app/data/datasources/story/location/location_story_remote_data_source.dart';
import 'package:story_app/data/datasources/story/upload/upload_story_remote_data_source.dart';
import 'package:story_app/data/datasources/user/user_local_data_source.dart';
import 'package:story_app/data/datasources/user/user_remote_data_source.dart';
import 'package:story_app/data/repositories/story_repository.dart';
import 'package:story_app/data/repositories/user_repository.dart';
import 'package:story_app/presentation/bloc/story/detail/detail_story_bloc.dart';
import 'package:story_app/presentation/bloc/story/list/list_story_bloc.dart';
import 'package:story_app/presentation/bloc/story/location/location_story_bloc.dart';
import 'package:story_app/presentation/bloc/story/upload/upload_story_bloc.dart';
import 'package:story_app/presentation/bloc/user/auth/auth_bloc.dart';
import 'package:story_app/presentation/bloc/user/login/login_bloc.dart';
import 'package:story_app/presentation/bloc/user/profile/profile_bloc.dart';
import 'package:story_app/presentation/bloc/user/register/register_bloc.dart';
import 'package:story_app/presentation/screens/home/home_screen.dart';
import 'package:story_app/presentation/screens/navigation/navigation_screen.dart';
import 'package:story_app/presentation/screens/splash/splash_screen.dart';
import 'package:story_app/presentation/screens/story/detail/detail_story_screen.dart';
import 'package:story_app/presentation/screens/user/login/login_screen.dart';
import 'package:story_app/presentation/screens/user/register/register_screen.dart';
import 'package:story_app/utils/constant/color_constant.dart';
import 'package:story_app/utils/constant/const.dart';
import 'package:story_app/utils/constant/name_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: geminiKey);
  SharedPreferences.getInstance().then((SharedPreferences sharedPreferences) {
    final userRemote = UserRemoteDataSource();
    final userLocal = UserLocalDataSource(sharedPreferences: sharedPreferences);
    final userRepository = UserRepository(userRemote, userLocal);
    final listStoryRemote = ListStoryRemoteDataSource();
    final locationStoryRemote = LocationStoryRemoteDataSource();
    final detailStoryRemote = DetailStoryRemoteDataSource();
    final uploadStoryRemote = UploadStoryRemoteDataSource();
    final storyRepository = StoryRepository(userLocal, listStoryRemote,
        detailStoryRemote, uploadStoryRemote, locationStoryRemote);
    runApp(MyApp(
      userRepository: userRepository,
      storyRepository: storyRepository,
    ));
  });
}
                                   
class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final StoryRepository storyRepository;

  const MyApp(
      {super.key, required this.userRepository, required this.storyRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(userRepository),
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(userRepository),
          ),
          BlocProvider<ListStoryBloc>(
            create: (context) => ListStoryBloc(storyRepository),
          ),
          BlocProvider<LocationStoryBloc>(
            create: (context) => LocationStoryBloc(storyRepository),
          ),
          BlocProvider<DetailStoryBloc>(
            create: (context) => DetailStoryBloc(storyRepository),
          ),
          BlocProvider<UploadStoryBloc>(
            create: (context) => UploadStoryBloc(storyRepository),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(userRepository),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(userRepository),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: NameRoutes.initRoute,
          routes: {
            NameRoutes.initRoute: (context) => const SplashScreen(),
            NameRoutes.registerPageRoute: (context) => const RegisterScreen(),
            NameRoutes.loginPageRoute: (context) => const LoginScreen(),
            NameRoutes.homePageRoute: (context) => const HomeScreen(),
            NameRoutes.navigationPageRoute: (context) =>
                const NavigationScreen(),
            NameRoutes.detailStoryPageRoute: (context) =>
                const DetailStoryScreen(),
          },
          theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: ColorConstant.mobileBackgroundColor),
        ));
  }
}
