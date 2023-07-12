import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:simpleapp/constant/constant.dart';
import '../provider/user_view_model.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  // late String firstName = '';

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp)  {
      Provider.of<UserViewModel>(context, listen: false).getUser(
        pages: 1,
        perPages: 5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViews = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.6,
          title: const Text('Third Screen', style: TextStyle(color: Colors.black)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Provider.of<UserViewModel>(context, listen: false).getUser(
              pages: 1,
              perPages: 10,
            );
          },
          child: userViews.dataStatus == DataStatus.loading 
            ? const Center(
                child: SpinKitCircle(color: primaryColor, size: 90)
              )
            : userViews.dataStatus == DataStatus.error
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text('Failed to load data...', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ],
                  ),
                )
              : userViews.user.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 50),
                        SizedBox(height: 10),
                        Text('No data found...'),
                      ],
                    ),
                  )
                : AnimationLimiter(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      shrinkWrap: true,
                      itemCount: userViews.user.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 1,
                          child: SlideAnimation(
                            horizontalOffset: 150.0,
                            curve: Curves.easeInOutCubic,
                            child: ListTile(
                              onTap: () {
                                final selectedUser = Provider.of<SelectedUser>(context, listen: false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('You selected ${userViews.user[index].firstName}'),
                                    duration: const Duration(milliseconds: 600),
                                  ),
                                );
                                selectedUser.selectedUser(userViews.user[index].firstName!);
                              },
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[300],
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: userViews.user[index].avatar!,
                                    placeholder: (context, url) => SpinKitCircle(color: Colors.grey[300]!),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              title: Text(
                                userViews.user[index].firstName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 18
                                ),
                              ),
                              subtitle: Text(
                                userViews.user[index].email!,
                                style: const TextStyle( 
                                  fontSize: 14
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ),
        ),
      ),
    );
  }
}