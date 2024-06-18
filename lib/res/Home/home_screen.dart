import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'bloc/home_result_bloc.dart';
import 'bloc/home_result_event.dart';
import 'bloc/home_result_state.dart';
import 'model/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;

  List<Results>? results = [];
  String? error;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeResultBloc>(
      create: (_) => HomeResultBloc()..add(HomeLandingStarted(page: page)),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Movie List With Bloc pattern",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        body: BlocBuilder<HomeResultBloc, HomeResultState>(
          builder: (ctx, state) {
            if (state is HomeResultLoading) {
              loading = true;
            }

            if (state is HomeResultLoaded) {
              results = state.getResult().results;
              loading = false;
              error = null;
            }

            if (state is HomeError) {
              error = 'Something went wrong! Please try again';
            }

            return loading
                ? Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : error != null
                    ? Center(child: Text(error!))
                    : results!.length == 0
                        ? SafeArea(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'No Data Found',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )),
                          )
                        : Container(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: results!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              color: Colors.lightBlueAccent,
                                              width: 2,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(

                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.network(
                                                results![index].imageUrl!,
                                                height: 80,
                                                width: 80,
                                                 fit: BoxFit.fill,
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                     "Movie : "+results![index].title!,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                      color: Colors.white),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                     "Description : "+ results![index].body!,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.normal,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    //  Divider(thickness: 1)
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
          },
        ),
      ),
    );
  }
}
