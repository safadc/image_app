import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_app/controller/image_controller.dart';
import 'package:image_app/helper/app_colors.dart';
import 'package:image_app/pages/add_image_screen.dart';
import 'package:image_app/widgets/phot_viewer.dart';
import 'package:intl/intl.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key, required this.folder, required this.controller})
      : super(key: key);
  final DocumentSnapshot<Object?> folder;
  final ImageController controller;

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 150,
        leading: Container(
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.center,
          child: const Text(
            "Photos Gallery",
            style: TextStyle(
              color: AppColor.green,
              fontSize: 15,
            ),
          ),
        ),
        elevation: 1,
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage(
              "assets/images/profile.jpg",
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Sanem",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "1001",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.folder['name'],
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Created on: ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(widget.folder['datetime']))}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    widget.controller.imagesStream(widget.folder.reference.id),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshots.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  DocumentSnapshot data = snapshots.data! as DocumentSnapshot;
                  final images = data.get("images") as List;
                  return GridView.builder(
                    itemCount: images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (c, i) {
                      final image = images[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) {
                            return PhotoViewer(image: image);
                          }));
                        },
                        child: Image.network(
                          image['image'],
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) {
              return AddImagePage(
                folder: widget.folder,
                controller: widget.controller,
              );
            }));
          },
          backgroundColor: AppColor.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.file_upload_outlined,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Upload",
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
