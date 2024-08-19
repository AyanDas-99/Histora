import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:histora/state/gps/respository/gps_repository.dart';
import 'package:histora/state/structure/models/history.dart';
import 'package:histora/state/gps/models/coordinate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String get name => 'home';

  static String get path => '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthStateLoggedIn) {
                return Text('${state.user.uid} ${state.user.displayName}');
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(Logout());
            },
            child: const Text('Log out'),
          ),
          Text("hello world"),
          const SizedBox(height: 20),
          History(history: '''
 <h1>Heading 1</h1>
 <h2>Heading 2</h1>
 <p style = 'color: red'> THis is a paragraph</p> 
''').build(),
          const LocationWidget(),
        ],
      ),
    );
  }
}

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool loading = false;
  Stream<Coordinate>? stream;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (stream != null)
          StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              final coordinate = snapshot.data;
              if (coordinate != null) {
                return Text(
                    'Location :: lat: ${coordinate.$1} lon: ${coordinate.$2}');
              } else {
                return Text('Loading..');
              }
            },
          )
        else
          Text('Nothing Yet'),
        if (loading) CircularProgressIndicator(),
        TextButton(
            onPressed: () async {
              setState(() {
                loading = true;
              });

              stream = await GpsRepositoryImpl(
                      geolocatorAndroid: GeolocatorAndroid())
                  .liveLocation();
              setState(() {
                loading = false;
              });
            },
            child: Text('Get location'))
      ],
    );
  }
}
