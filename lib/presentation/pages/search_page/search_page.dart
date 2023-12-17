import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/provider/list_of_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchC = TextEditingController(text: "");
  bool isFocus = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colorGray100,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: TextField(
                controller: searchC,
                autofocus: true,
                onTap: () {},
                onChanged: (value) {
                  setState(() {
                    searchC.text = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search restaurant',
                  hintStyle: body1reg.copyWith(
                    color: colorGray500,
                  ),
                  border: InputBorder.none,
                  icon: const Icon(
                    Icons.search,
                    size: 24,
                  ),
                  suffixIcon: searchC.text == ""
                      ? const Icon(
                          Icons.mic,
                        )
                      : const Icon(
                          Icons.cancel_outlined,
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Consumer<ListOfSearchProvider>(
              builder: (context, value, child) {
                if (value.historySearch.isEmpty) {
                  print('test');
                  return const SizedBox(
                    height: 0,
                  );
                } else {
                  print('test');
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.historySearch.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Text(
                                value.historySearch[index],
                                style: body1reg,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Icon(
                              Icons.cancel_outlined,
                              color: colorGray500,
                              size: 24,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
