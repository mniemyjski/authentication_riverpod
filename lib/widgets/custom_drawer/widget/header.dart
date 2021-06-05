import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColorDark.withOpacity(0.6),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(AccountEditScreen.routeName);
            },
            child: Stack(children: <Widget>[
              Positioned(
                bottom: 40.0,
                left: 16.0,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.black12,
                  child: false
                      ? CachedNetworkImage(
                          imageUrl: "",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black87, width: 1.0),
                              image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.account_circle,
                            size: 110,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.account_circle,
                          size: 110,
                          color: Colors.white,
                        ),
                ),
              ),
              Positioned(
                  bottom: 8.0,
                  left: 16.0,
                  child: Text(
                    "",
                    style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
                  )),
            ]),
          )),
    );
  }
}
