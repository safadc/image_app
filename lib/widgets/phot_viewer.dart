import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({Key? key, required this.image}) : super(key: key);
  final Map image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Photos Gallery",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.7,
              child: PhotoView(
                minScale: 0.2,
                maxScale: 0.8,
                imageProvider: NetworkImage(image['image']),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(image['title'],style: const TextStyle(color: Colors.white,fontSize: 15),),
                  const SizedBox(height: 20,),
                  Text(image['description'],style: const TextStyle(color: Colors.white,fontSize: 12),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
