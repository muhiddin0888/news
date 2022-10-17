import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/notification/notification_cubit.dart';
import '../cubit/notification/notification_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "News",
          ),
          leading: IconButton(
            iconSize: 24,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
          ),
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
          if (state is GetNotificationProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetNotificationInFailure) {
            return Center(child: Text(state.errorText));
          } else if (state is GetNotificationInSuccess) {
            return ListView(
              children: List.generate(state.news.length, (index) {
                var item = state.news[index];
                return ExpansionTile(
                  trailing: Image.network(
                    item.newsImage,
                    width: 180,
                    height: 300,
                  ),
                  title: Text(item.newsTitle),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(item.newsText),
                          Text(item.createdAt),
                        ],
                      ),
                    )
                  ],
                );
              }),
            );
          }

          return const SizedBox();
        }));
  }
}
