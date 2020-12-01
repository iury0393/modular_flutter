import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_flutter/app/pages/home/home_controller.dart';
import 'package:modular_flutter/app/shared/models/Pokemon.dart';
import 'package:modular_flutter/app/shared/utils/base_response.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    homeController.fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: StreamBuilder<BaseResponse<List<Pokemon>>>(
            stream: homeController.pokemonStreamController.stream,
            builder: (context, snapshot) {
              switch (snapshot.data?.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case Status.ERROR:
                  return Center(
                    child: Text('Erro'),
                  );
                  break;
                default:
                  if (snapshot.data?.data != null) {
                    if (snapshot.data.data.isNotEmpty) {
                      return ListView.builder(
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data.data[index].name),
                            );
                          });
                    }
                  }
                  break;
              }
              return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Modular.to.pushNamed('/other');
        },
      ),
    );
  }
}
