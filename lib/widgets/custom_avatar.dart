import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    Key? key,
    this.url = '',
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 55,
      backgroundColor: Colors.black12,
      child: url != ''
          ? CachedNetworkImage(
              imageUrl: url,
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
    );
  }
}
