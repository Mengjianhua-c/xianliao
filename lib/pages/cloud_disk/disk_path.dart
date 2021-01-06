import 'package:xianliao/blocs/bloc_base.dart';
import 'package:flutter/material.dart';
import 'package:xianliao/blocs/bloc_provider.dart';
import 'package:xianliao/blocs/cloud_disk/cloud_disk_bloc.dart';

class DiskPathProvider extends StatefulWidget {
  @override
  _DiskPathProviderState createState() => _DiskPathProviderState();
}

class _DiskPathProviderState extends State<DiskPathProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(child: DiskPathPage(), bloc: DiskPathBloc());
  }
}



class DiskPathPage extends StatefulWidget {
  @override
  _DiskPathPageState createState() => _DiskPathPageState();
}

class _DiskPathPageState extends State<DiskPathPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
