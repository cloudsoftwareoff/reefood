import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/services/users/xUser.dart';

class MyAppBar extends StatelessWidget {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget title;
  final Widget subtitle;
  final Builder? leadingIcon;
  final VoidCallback? onTap;

  const MyAppBar({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    required this.title,
    required this.subtitle,
    this.leadingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final cp = context.watch<CartProvider>();
    int totalQuantity = 0;

    // for (int i = 0; i < cp.cart.length; i++) {
    //   totalQuantity += cp.cart[i].quantity;
    // }

    return SliverAppBar(
      foregroundColor: Colors.white, //foregroundColor ?? Colors.white,
      backgroundColor: Colors.pink, // backgroundColor ?? scheme.primary,
      expandedHeight: 110,
      collapsedHeight: 60,
      forceElevated: true,
      elevation: 0,
      shadowColor: Colors.transparent,
      floating: true,
      pinned: true,
      leading: leadingIcon ??
          BackButton(
            color: foregroundColor == null ? Colors.white : scheme.primary,
          ),
      actions: [
        IconButton(
          visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: Icon(
            Icons.favorite_border_rounded,
            color: Colors.white,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, CartScreen.routeName);
              },
              padding: EdgeInsets.zero,
              icon: Icon(Icons.navigate_before, color: Colors.white),
            ),
            totalQuantity == 0
                ? const SizedBox()
                : Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: foregroundColor == null
                            ? Colors.white
                            : scheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            totalQuantity.toString(),
                            style: TextStyle(
                              color: foregroundColor == null
                                  ? scheme.primary
                                  : Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        )
      ],
      title: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title, subtitle],
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    //Navigator.pushNamed(context, SearchScreen.routeName);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 38,
                    decoration: BoxDecoration(
                      color: backgroundColor == scheme.primary
                          ? Colors.white
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_outlined,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Search for shops & restaurants',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarUI extends StatefulWidget {
  const AppBarUI({super.key});

  @override
  State<AppBarUI> createState() => _AppBarUIState();
}

class _AppBarUIState extends State<AppBarUI> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      floating: true,
      pinned: true,
      title: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TopAppBar(),
          ],
        ),
      ),
    );
  }
}

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<UserProfile?>(
          future: UserProfileProvider()
              .userProfileById(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              UserProfile userProfile = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side content
                        Row(
                          children: [
                            Icon(
                              Icons.radio_button_checked_sharp,
                              color: scheme.primary,
                              size: 24,
                            ),
                            SizedBox(width: 8), // Adjust the spacing as needed
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${userProfile.ipLocation}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: scheme.primary,
                                  ),
                                ),
                                Text(
                                  "Within 10Km",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: scheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Right side content
                        Icon(
                          Icons.arrow_drop_down,
                          color: scheme.primary,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}

class SearchBusiness extends StatelessWidget {
  const SearchBusiness({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          //Navigator.pushNamed(context, SearchScreen.routeName);
        },
        child: Container(
          //width: doubsle.infinity,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Icon(
                  Icons.search_outlined,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Icon(
                  Icons.clear_outlined,
                  color: Colors.grey[700],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
