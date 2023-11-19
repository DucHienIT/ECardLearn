import 'package:flutter/material.dart';

import '../pages/user/PageProfile.dart';


class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}


class MenuBarCustom extends StatelessWidget {
  const MenuBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.home),
            label: Text('Home'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Do something when button 1 is pressed
            },
            icon: Icon(Icons.notifications),
            label: Text('Notifi'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if(Navigator.canPop(context))
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  PageProfile()),
                );
              }
              else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageProfile()),
                );
              }

            },
            icon: Icon(Icons.person),
            label: Text('Personal'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}