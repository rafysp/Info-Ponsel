import 'package:flutter/material.dart';
import 'package:info_ponsel/model/phone_list_model.dart';

class PhoneListItem extends StatelessWidget {
  final PhoneListModel phone;
  final VoidCallback onTap;

  const PhoneListItem({
    required this.phone,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.blue.withOpacity(0.1),
              ],
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  '${phone.phoneName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(phone.description ?? ''),
                leading: phone.imageUrl != null && phone.imageUrl!.isNotEmpty
                    ? Image.network(
                        phone.imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(
                        width: 80,
                        height: 80,
                        child: Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}