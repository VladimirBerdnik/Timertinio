import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullscreenCarousel extends StatefulWidget {
  final String title;
  final List<String> images;

  FullscreenCarousel(this.title, this.images);

  @override
  State<StatefulWidget> createState() => FullscreenCarouselState();
}

class FullscreenCarouselState extends State<FullscreenCarousel> {
  List<String> _images;
  String _title;

  @override
  void initState() {
    _images = widget.images;
    _title = widget.title;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topBar = new AppBar(
      centerTitle: true,
      elevation: 1.0,
      title: Text(_title, style: TextStyle(fontWeight: FontWeight.bold)),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.chevron_left),
      ),
    );

    return Scaffold(
        appBar: topBar,
        body: Container(
            child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(_images[index]),
              initialScale: PhotoViewComputedScale.contained * 0.9,
              heroAttributes: PhotoViewHeroAttributes(tag: _images[index]),
            );
          },
          itemCount: _images.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          ),
          backgroundDecoration: BoxDecoration(color: Theme.of(context).canvasColor),
        )));
  }
}
