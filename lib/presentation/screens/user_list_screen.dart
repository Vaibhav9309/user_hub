import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:user_hub/presentation/bloc/user_bloc.dart';
import 'package:user_hub/presentation/widgets/empty_state_widget.dart';
import 'package:user_hub/presentation/widgets/search_bar.dart';
import 'package:user_hub/presentation/widgets/user_card.dart';
import 'package:user_hub/presentation/widgets/user_shimmer_list.dart';
import '../../main.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUsers());
    _scrollController.addListener(_onScroll);
    _searchController.addListener(() => setState(() {}));
  }

  void _onScroll() {
    final bloc = context.read<UserBloc>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200 &&
        !bloc.state.isLoading) {
      bloc.add(FetchUsers());
    }
  }

  void _onRefresh() {
    context.read<UserBloc>().add(RefreshUsers());
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text(
            'Users',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round),
              onPressed: () {
                final brightness = Theme.of(context).brightness;
                final mode = brightness == Brightness.dark
                    ? ThemeMode.light
                    : ThemeMode.dark;
                MyApp.of(context)!.changeTheme(mode);
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          final users = state.users;

          if (state.isLoading && users.isEmpty) {
            return const UserShimmerList(itemCount: 6);
          } else if (state.error != null && users.isEmpty) {
            return EmptyStateWidget(
              title: "Failed to load users",
              description: state.error ?? "Something went wrong.",
              buttonText: "Try Again",
              imagePath: 'assets/images/img.png',
              onRetry: () => context.read<UserBloc>().add(FetchUsers()),
            );
          }

          final filtered = users
              .where((u) => u.name
              .toLowerCase()
              .contains(state.searchQuery.toLowerCase()))
              .toList();

          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: Column(
              children: [
                SearchBarWidget(
                  controller: _searchController,
                  onChanged: (q) =>
                      context.read<UserBloc>().add(SearchUsers(q)),
                  onClear: () {
                    _searchController.clear();
                    context.read<UserBloc>().add( SearchUsers(''));
                    setState(() {});
                  },
                ),
                if (filtered.isEmpty && state.searchQuery.isNotEmpty)
                  Expanded(
                    child: Center(
                      child: EmptyStateWidget(
                        title: "No users found",
                        description:
                        "Try a different name or clear your search.",
                        buttonText: "Clear Search",
                        imagePath: 'assets/images/img.png',
                        onRetry: () {
                          _searchController.clear();
                          context
                              .read<UserBloc>()
                              .add( SearchUsers(''));
                          setState(() {});
                        },
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: filtered.length + (state.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < filtered.length) {
                          final user = filtered[index];
                          return UserCard(
                            user: user,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      UserDetailScreen(user: user),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
