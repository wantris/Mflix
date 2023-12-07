import 'package:flutter/material.dart';
import 'package:movie_db/constants/constant.dart';

class UpperAppBar extends StatefulWidget implements PreferredSizeWidget{
  final AppBar appBar;

  const UpperAppBar({super.key, required this.appBar}); 

  @override
  State<UpperAppBar> createState() => _UpperAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _UpperAppBarState extends State<UpperAppBar> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = RichText(text: const TextSpan(
    children: <TextSpan>[
      TextSpan(
        text: 'M',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.red
        )
      ),
      TextSpan(
        text: 'flix',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white
        )
      )
    ]
  ));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 7.5),
          ),
        ],
      ),
      child: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        backgroundColor: Constants.secondaryColor,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                if(customIcon.icon == Icons.search){
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = const ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'type movie name...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic
                        ),
                        border: InputBorder.none
                      ),
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  );
                }else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = RichText(text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'M',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.red
                        )
                      ),
                      TextSpan(
                        text: 'flix',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                           fontSize: 24,
                          color: Colors.white
                        )
                      )
                    ]
                  ));
                }
              });
            },
            icon: customIcon,
          )
        ],
      ),
    );
  }
}

class BaseBottomNavBar extends StatefulWidget {
  final PageController pageController;

  const BaseBottomNavBar({super.key, required this.pageController});

  @override
  State<BaseBottomNavBar> createState() => _BaseBottomNavBarState();
}

class _BaseBottomNavBarState extends State<BaseBottomNavBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      widget.pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 7.5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Constants.secondaryColor,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_max,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_border,
            ),
            label: 'Watch List'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wifi_tethering,
            ),
            label: 'Profile'
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedIconTheme: const IconThemeData(
          size: 25,
        ),
        selectedIconTheme: const IconThemeData(
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
    );
  }
}