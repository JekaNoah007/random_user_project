import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user_project/bloc/getuser_bloc.dart';
import 'package:random_user_project/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final userBloc = GetuserBloc();

  @override
  void initState() {
    userBloc.add(GetAllEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 45, 45),
      body: BlocProvider(
        create: (context) => userBloc,
        child: BlocConsumer<GetuserBloc, GetUserState>(
          bloc: userBloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetuserLoaded) {
              return RandomUser(userModal: state.data);
            } else if (state is GetuserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetuserError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const Center(
              child: Text("Download data"),
            );
          },
        ),
      ),
    );
  }
}

class RandomUser extends StatelessWidget {
  const RandomUser({Key? key, required this.userModal}) : super(key: key);

  final UserModal userModal;

  @override
  void launchURL() async {
    const url =
        'https://www.google.com/maps/place/Al+qi,+ADoqi,+Giza+Governorate/@33.0523046,38.2009323,17z/data=!3m1!4b1!4m5!3m4!1s0x1458413a996ec217:0x2411f6b62d93ccc!8m2!3d30.05237!4d31.2031598';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundColor: Color.fromARGB(255, 39, 37, 37),
              child: CircleAvatar(
                backgroundImage: userModal
                        .results!.first.picture!.medium!.isEmpty
                    ? null
                    : NetworkImage(
                        userModal.results!.first.picture!.medium.toString()),
                radius: 73,
                child: userModal.results!.first.picture!.medium!.isNotEmpty
                    ? null
                    : Text(
                        '${userModal.results!.first.name!.first!.substring(0, 1).toUpperCase()}${userModal.results!.first.name!.last!.substring(0, 1).toUpperCase()}'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              '${userModal.results!.first.name}',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Icon(Icons.add, size: 50),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 90, 86, 86), width: 1),
                    primary: const Color.fromARGB(255, 51, 45, 45),
                    minimumSize: const Size(150, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Icon(Icons.iso, size: 50),
                  onPressed: () {
                    launchURL;
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 90, 86, 86), width: 1),
                    primary: const Color.fromARGB(255, 51, 45, 45),
                    minimumSize: const Size(150, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text(
                    "Men",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 90, 86, 86), width: 1),
                    primary: userModal.results!.first.gender == "male"
                        ? Colors.grey
                        : const Color.fromARGB(255, 51, 45, 45),
                    minimumSize: const Size(100, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    "Both",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 90, 86, 86), width: 1),
                    primary: userModal.results!.first.gender == null
                        ? Colors.grey
                        : const Color.fromARGB(255, 51, 45, 45),
                    minimumSize: const Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        (0),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    "Women",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 90, 86, 86), width: 1),
                    primary: userModal.results!.first.gender == "female"
                        ? Colors.grey
                        : const Color.fromARGB(255, 51, 45, 45),
                    minimumSize: const Size(100, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "1 user generated this session",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.cached, size: 60),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 182, 253, 67),
                  minimumSize: const Size(300, 70)),
            ),
          ],
        ),
      ),
    );
  }
}
