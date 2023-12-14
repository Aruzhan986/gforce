import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gforce/generated/locale_keys.g.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';
import 'package:story_view/story_view.dart';
import 'package:image_picker/image_picker.dart';

class Story {
  final String imageUrl;
  final Duration duration;
  bool isViewed;

  Story(
      {required this.imageUrl, required this.duration, this.isViewed = false});
}

class StoriesView extends StatefulWidget {
  @override
  _StoriesViewState createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView> {
  final StoryController controller = StoryController();
  List<Story> stories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Stories.tr()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  return StoryThumbnail(
                    story: stories[index],
                    onTap: () => showStory(stories[index]),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageNames.length,
              itemBuilder: (context, index) {
                return ChannelsCard(
                  channelName: "Channel $index",
                  assetImagePath: 'assets/images/${imageNames[index]}',
                  isSubscribed: index % 2 == 0,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => pickImage(),
      ),
    );
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        stories
            .add(Story(imageUrl: image.path, duration: Duration(seconds: 5)));
      });
    } else {
      print("No image selected");
    }
  }

  void showStory(Story story) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FullScreenStoryView(story: story)));
    setState(() {
      story.isViewed = true;
    });
  }
}

class StoryThumbnail extends StatelessWidget {
  final Story story;
  final VoidCallback onTap;

  const StoryThumbnail({Key? key, required this.story, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: CircleAvatar(
          radius: 45,
          backgroundColor: story.isViewed
              ? PrimaryColors.Colorsix
              : PrimaryColors.Colorseven,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(story.imageUrl),
          ),
        ),
      ),
    );
  }
}

class FullScreenStoryView extends StatelessWidget {
  final Story story;

  const FullScreenStoryView({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoryController controller = StoryController();
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.pageImage(
              url: story.imageUrl,
              controller: controller,
              duration: story.duration)
        ],
        controller: controller,
        onComplete: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ChannelsCard extends StatelessWidget {
  final String channelName;
  final String assetImagePath;
  final bool isSubscribed;

  const ChannelsCard({
    Key? key,
    required this.channelName,
    required this.assetImagePath,
    this.isSubscribed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 250,
      child: Card(
        child: Column(
          children: <Widget>[
            Image.asset(assetImagePath, width: 100, height: 60),
            Text(channelName),
            isSubscribed
                ? Icon(Icons.check, color: PrimaryColors.Colorfive)
                : Container(),
          ],
        ),
      ),
    );
  }
}

List<String> imageNames = ['image11.png', 'image12.png', 'image13.png'];
