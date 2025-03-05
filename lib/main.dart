import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shop/features/investment/home/data/datasource/investment_datasource.dart';
import 'package:shop/features/investment/home/data/repository/investment_repo_impl.dart';
import 'package:shop/features/investment/home/presentation/bloc/investment_cubit.dart';
import 'package:shop/features/investment/home/presentation/screens/investment_home_screen.dart';

void main() {
  final dio = Dio();
  final dataSource = InvestmentDataSource(dio);
  final repository = InvestmentRepositoryImpl(dataSource);
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final InvestmentRepositoryImpl repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InvestmentCubit(repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InvestHomePage(),
      ),
    );
  }
}