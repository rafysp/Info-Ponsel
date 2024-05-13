import 'package:flutter/material.dart';
import 'package:info_ponsel/pages/phone_detail.dart';

class FavoriteListTile extends StatelessWidget {
  final Map<String, dynamic> phone;
  final Function(String) onRemove;

  const FavoriteListTile({
    required this.phone,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${phone['brandName']} - ${phone['phoneName'] ?? ''}',
      ),
      subtitle: Text(phone['description']),
      leading: Image.network(
        phone['imageUrl'],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          onRemove(phone['phoneId']);
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneDetailPage(
              phoneId: phone['phoneId'],
              imageUrl: phone['imageUrl'],
              phoneName: phone['phoneName'],
              description: phone['description'],
              brandName: phone['brandName'] ?? '',
            ),
          ),
        );
      },
    );
  }
}
