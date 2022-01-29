import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/screens/profile_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool showUsers = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          width: double.infinity,
          height: 40,
          color: Colors.black,
          child: TextField(
            controller: _searchController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                labelText: 'Search',
                fillColor: Colors.grey[300],
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.grey[300]),
                border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context)),
                suffixIcon: const Icon(
                  Icons.crop_free_rounded,
                  color: Colors.white,
                )),
            onSubmitted: (String _) {
              setState(() {
                showUsers = true;
              });
              //print(_);
              //print(_searchController.text);
            },
          ),
        ),
      ),
      body: showUsers == true
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: _searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                uid: (snapshot.data! as dynamic).docs[index]
                                    ['uid']),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photoUrl'],
                            ),
                          ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]['username'],
                          ),
                        ),
                      );
                    });
              })
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        SearchField(fieldname: 'IGTV', iconId: 0xf16f),
                        SearchField(fieldname: 'Shop', iconId: 0xe59c),
                        SearchField(fieldname: 'Style', iconId: 0xe613),
                        SearchField(fieldname: 'Sports', iconId: 0xf3cb),
                        SearchField(fieldname: 'Auto', iconId: 0xe13c),
                        SearchField(fieldname: 'Persons', iconId: 0xe491),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Expanded(
                  child: FutureBuilder(
                      future:
                          FirebaseFirestore.instance.collection('posts').get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(1),
                                child: Image.network(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['postUrl'],
                                  fit: BoxFit.cover,
                                ),
                              );
                            });
                      }),
                ),
              ],
            ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({Key? key, required this.fieldname, required this.iconId})
      : super(key: key);

  final String fieldname;
  final int iconId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            primary: Colors.black,
            side: const BorderSide(width: 0.5, color: Colors.white)),
        child: Row(
          children: [
            Row(
              children: [
                Icon(IconData(iconId, fontFamily: 'MaterialIcons')),
                const SizedBox(
                  width: 2.5,
                ),
                Text(
                  fieldname,
                  style: const TextStyle(fontStyle: FontStyle.normal),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
