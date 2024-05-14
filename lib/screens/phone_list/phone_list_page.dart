import 'package:flutter/material.dart';
import 'package:info_ponsel/screens/phone_detail/phone_detail.dart';
import 'package:info_ponsel/screens/phone_list/widget/phone_list_item.dart';
import 'package:info_ponsel/model/phone_list_model.dart';
import 'package:info_ponsel/model/service/phone_list_service.dart';

class PhoneListPage extends StatefulWidget {
  final int brandId;
  final String brandName;

  PhoneListPage({required this.brandId, required this.brandName});

  @override
  _PhoneListPageState createState() => _PhoneListPageState();
}

class _PhoneListPageState extends State<PhoneListPage> {
  List<PhoneListModel> phones = [];
  bool isLoading = true;
  late List<PhoneListModel> filteredPhones = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
    fetchPhones();
    searchController.addListener(searchPhones);
  }

  @override
  void dispose() {
    searchController.removeListener(searchPhones);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchPhones() async {
    List<PhoneListModel> fetchedPhones =
        await PhoneListService.fetchPhonesByBrand(
            widget.brandId, currentPage, pageSize);
    if (mounted) {
      // Cek apakah widget masih ada di dalam tree sebelum melakukan setState
      setState(() {
        phones.addAll(fetchedPhones);
        filteredPhones = phones;
        isLoading = false;
      });
    }
  }

  void searchPhones() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredPhones = phones;
      } else {
        filteredPhones = phones.where((phone) {
          final name = phone.phoneName?.toLowerCase();
          final description = phone.description?.toLowerCase();
          return name != null &&
              description != null &&
              (name.contains(query) || description.contains(query));
        }).toList();
      }
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      filteredPhones = phones;
    });
  }

  void loadNextPage() {
    setState(() {
      currentPage++;
    });
    fetchPhones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.brandName} Phones'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => searchPhones(),
                    decoration: InputDecoration(
                      labelText: 'Search Phones',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: clearSearch,
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredPhones.isEmpty
                    ? Center(
                        child: Text('No phones found'),
                      )
                    : NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            loadNextPage();
                            return true;
                          }
                          return false;
                        },
                        child: Scrollbar(
                          thumbVisibility: true,
                          interactive: true,
                          thickness: 10,
                          radius: Radius.circular(15),
                          child: ListView.builder(
                            itemCount: filteredPhones.length,
                            itemBuilder: (context, index) {
                              var phone = filteredPhones[index];
                              return PhoneListItem(
                                phone: phone,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhoneDetailPage(
                                        phoneId: phone.id,
                                        imageUrl: phone.imageUrl,
                                        phoneName: phone.phoneName,
                                        description: phone.description,
                                        brandName: widget.brandName,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
