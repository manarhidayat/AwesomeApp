import 'package:awesome_app/presenter/blocs/photos/photos_bloc.dart';
import 'package:awesome_app/presenter/blocs/photos/photos_event.dart';
import 'package:awesome_app/presenter/blocs/photos/photos_state.dart';
import 'package:awesome_app/presenter/widgets/photos_grid.dart';
import 'package:awesome_app/presenter/widgets/photos_list.dart';
import 'package:awesome_app/core/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "/main";

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  static const String routeName = "/main";

  bool _isGrid = true;
  final _scrollController = ScrollController();

  late PhotosBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _bloc = BlocProvider.of(context);
    _bloc.add(PhotosInitial());

    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent){
        _bloc.add(PhotosFetched());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              title: (innerBoxIsScrolled) ? Text("Awesome App") : Text("Awesome App"),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(banner)
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.grid_view,
                    color: (_isGrid) ? Colors.white : Color(0xffbfbfbf),
                  ),
                  onPressed: () {
                    setState(() {
                      _isGrid = true;
                    });
                  }
                ),
                IconButton(
                  icon: Icon(
                    Icons.list,
                    color: (!_isGrid) ? Colors.white : Color(0xffbfbfbf),
                  ),
                  onPressed: () {
                    setState(() {
                      _isGrid = false;
                    });
                  }
                ),
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: BlocConsumer<PhotosBloc, PhotosState>(
            listener: (context, state){
              if(state.status == PhotosStatus.failure){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Load photos failed"),
                  action: SnackBarAction(
                    label: "Retry",
                    onPressed: () => _bloc.add(PhotosFetched()),
                  ),
                ));
              }
            },
            builder: (context, state){
              switch (state.status) {
                case PhotosStatus.failure:
                  return const Center(child: Text('Failed to fetch photo'));
                case PhotosStatus.success:
                  if (state.list.isEmpty) {
                    return const Center(child: Text('No photo'));
                  }
                  final photos = state.list;
                  return (_isGrid) ? PhotosGrid(photos) : PhotosList(photos);
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
} 