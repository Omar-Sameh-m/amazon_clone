import 'package:amazon_clone/blocs/user_details/user_details_bloc.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;
  const UserDetailsBar({super.key, required this.offset});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      builder: (context, state) {
        String name = "Loading";
        String address = "Loading";
        if (state is UserDetailsLoaded) {
          name = state.userDetails.name;
          address = state.userDetails.address;
        }

        return Positioned(
          top: -offset / 3,
          child: Container(
            height: kAppBarHeight / 2,
            width: screenSize.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: lightBackgroundaGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey[900],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.7,
                    child: Text(
                      "Deliver to $name - $address ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
