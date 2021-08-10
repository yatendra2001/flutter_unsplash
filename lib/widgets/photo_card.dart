import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_upsplash/models/photo_model.dart';
import 'package:flutter_upsplash/screens/screens.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;
  final int index;
  final List<Photo> photos;

  const PhotoCard({Key key, this.photo, this.index, this.photos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PhotoViewerScreen(
          photos: photos,
          currentIndex: index,
        ),
      )),
      child: Hero(
        tag: Key('${index}_${photo.id}'),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              const BoxShadow(
                  color: Colors.black26, offset: Offset(0, 2), blurRadius: 4.0),
            ],
            image: DecorationImage(
                image: CachedNetworkImageProvider(photo.url),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
