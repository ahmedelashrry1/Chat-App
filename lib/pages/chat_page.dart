

import 'package:chat_app/pages/chat_detials.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key, required String email});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> users = [
    {'name': 'Ahmed', 'icon': 'assets/personal/bussiness-man.png'},
    {'name': 'Sara', 'icon': 'assets/personal/businesswoman (1).png'},
    {'name': 'Omar', 'icon': 'assets/personal/businesswoman.png'},
    {'name': 'Fatma', 'icon': 'assets/personal/happy.png'},
    {'name': 'Ali', 'icon': 'assets/personal/man (1).png'},
    {'name': 'Mona', 'icon': 'assets/personal/woman.png'},
    {'name': 'Youssef', 'icon': 'assets/personal/office-man.png'},
    {'name': 'Hana', 'icon': 'assets/personal/profile (1).png'},
    {'name': 'Mohamed', 'icon': 'assets/personal/woman (1).png'},
    {'name': 'Noha', 'icon': 'assets/personal/woman.png'},
    {'name': 'Amr', 'icon': 'assets/personal/bussiness-man.png'},
    {'name': 'Salma', 'icon': 'assets/personal/young-man.png'},
    {'name': 'Mostafa', 'icon': 'assets/personal/bussiness-man.png'},
    {'name': 'Dina', 'icon': 'assets/personal/businesswoman.png'},
    {'name': 'Hassan', 'icon': 'assets/personal/businesswoman.png'},
    {'name': 'Youssef', 'icon': 'assets/personal/office-man.png'},
    {'name': 'Hana', 'icon': 'assets/personal/profile (1).png'},
    {'name': 'Mohamed', 'icon': 'assets/personal/woman (1).png'},
    {'name': 'Noha', 'icon': 'assets/personal/woman.png'},
    {'name': 'Ahmed', 'icon': 'assets/personal/bussiness-man.png'},
    {'name': 'Sara', 'icon': 'assets/personal/businesswoman (1).png'},
    {'name': 'Omar', 'icon': 'assets/personal/businesswoman.png'},
    {'name': 'Fatma', 'icon': 'assets/personal/happy.png'},
    {'name': 'Ali', 'icon': 'assets/personal/man (1).png'},
    {'name': 'Mona', 'icon': 'assets/personal/woman.png'},
    {'name': 'Ahmed', 'icon': 'assets/personal/bussiness-man.png'},
    {'name': 'Sara', 'icon': 'assets/personal/businesswoman (1).png'},
    {'name': 'Omar', 'icon': 'assets/personal/businesswoman.png'},
    {'name': 'Fatma', 'icon': 'assets/personal/happy.png'},
    {'name': 'Ali', 'icon': 'assets/personal/man (1).png'},
    {'name': 'Mona', 'icon': 'assets/personal/woman.png'},
    {'name': 'Youssef', 'icon': 'assets/personal/office-man.png'},
    {'name': 'Hana', 'icon': 'assets/personal/profile (1).png'},
    {'name': 'Mohamed', 'icon': 'assets/personal/woman (1).png'},
    {'name': 'Noha', 'icon': 'assets/personal/woman.png'},
    {'name': 'Amr', 'icon': 'assets/personal/bussiness-man.png'},
    {'name': 'Salma', 'icon': 'assets/personal/young-man.png'},
    
  ];

  int _selectedIndex = 0;
  int _newMessagesCount = 3; // عدد الرسائل الجديدة
  int _newContactsCount = 5; // عدد جهات الاتصال الجديدة

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xff004170),
        foregroundColor: Colors.white, 
        title: const Text("Chats", style: TextStyle(fontSize: 30.0),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              padding: const EdgeInsets.fromLTRB(
                16.0,
                0,
                16.0,
                16.0,
              ),
              color: const Color(0xff004170),
              child: Form(
                child: TextFormField(
                  autofocus: false,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    // search
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.search,
                      color: const Color(0xFF1D1D35).withOpacity(0.64),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: const Color(0xFF1D1D35).withOpacity(0.64),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0 * 1.5, vertical: 16.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Phone contacts",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .color!
                                  .withOpacity(0.32),
                            ),
                      ),
                    ),
                    ...List.generate(
                      users.length,
                      (index) => ContactCard(
                        name: users[index]['name'],
                        image: users[index]['icon'],
                        isActive: index.isEven,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetails(
                                userName: users[index]['name'],
                                userIcon: users[index]['icon'],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.message),
                if (_newMessagesCount > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '$_newMessagesCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.contacts),
                if (_newContactsCount > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '$_newContactsCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Contacts',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Status',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff004170),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        elevation: 10,
      ),
    );
  }
}class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.name,
    required this.image,
    required this.isActive,
    required this.press,
  });

  final String name, image;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0 / 2),
      onTap: press,
      leading: CircleAvatarWithActiveIndicator(
        image: image,
        isActive: isActive,
        radius: 28,
      ),
      title: Text(name),
    );
  }
}

class CircleAvatarWithActiveIndicator extends StatelessWidget {
  const CircleAvatarWithActiveIndicator({
    super.key,
    required this.image,
    this.radius = 24,
    this.isActive = false,
  });

  final String image;
  final double radius;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage(image),
        ),
        if (isActive)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF00BF6D),
                shape: BoxShape.circle,
                border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor, width: 3),
              ),
            ),
          ),
      ],
    );
  }
}
// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:chat_app/pages/chat_detials.dart';

// class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   int _selectedIndex = 0;
//   int _newMessagesCount = 3; // عدد الرسائل الجديدة
//   int _newContactsCount = 1; // عدد جهات الاتصال الجديدة

//   final List<Map<String, dynamic>> users = [
//     {'name': 'Ahmed', 'icon': 'assets/personal/bussiness-man.png'},
//     {'name': 'Sara', 'icon': 'assets/personal/businesswoman (1).png'},
//     {'name': 'Omar', 'icon': 'assets/personal/businesswoman.png'},
//     {'name': 'Fatma', 'icon': 'assets/personal/happy.png'},
//     {'name': 'Ali', 'icon': 'assets/personal/man (1).png'},
//     {'name': 'Mona', 'icon': 'assets/personal/woman.png'},
//     {'name': 'Youssef', 'icon': 'assets/personal/office-man.png'},
//     {'name': 'Hana', 'icon': 'assets/personal/profile (1).png'},
//     {'name': 'Mohamed', 'icon': 'assets/personal/woman (1).png'},
//     {'name': 'Noha', 'icon': 'assets/personal/woman.png'},
//     {'name': 'Amr', 'icon': 'assets/personal/bussiness-man.png'},
//     {'name': 'Salma', 'icon': 'assets/personal/young-man.png'},
//     {'name': 'Mostafa', 'icon': 'assets/personal/bussiness-man.png'},
//     {'name': 'Dina', 'icon': 'assets/personal/businesswoman.png'},
//     {'name': 'Hassan', 'icon': 'assets/personal/businesswoman.png'},
//     {'name': 'Youssef', 'icon': 'assets/personal/office-man.png'},
//     {'name': 'Hana', 'icon': 'assets/personal/profile (1).png'},
//     {'name': 'Mohamed', 'icon': 'assets/personal/woman (1).png'},
//     {'name': 'Noha', 'icon': 'assets/personal/woman.png'},
//     {'name': 'Ahmed', 'icon': 'assets/personal/bussiness-man.png'},
//     {'name': 'Sara', 'icon': 'assets/personal/businesswoman (1).png'},
//     {'name': 'Omar', 'icon': 'assets/personal/businesswoman.png'},
//     {'name': 'Fatma', 'icon': 'assets/personal/happy.png'},
//     {'name': 'Ali', 'icon': 'assets/personal/man (1).png'},
//     {'name': 'Mona', 'icon': 'assets/personal/woman.png'},



//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Color(0xff004170), // لون شريط العنوان
//         elevation: 5,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/chat-app-abr.png',
//               height: 40,
//             ),
//             SizedBox(width: 10),
//             Text(
//               'Chat',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: Colors.white),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.settings, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: AssetImage(users[index]['icon']),
//               ),
//               title: Text(users[index]['name']),
//               subtitle: Text('Message $index'),
//               trailing: Text('12:30 PM'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChatDetials(
//                       userName: users[index]['name'],
//                       userIcon: users[index]['icon'], // تمرير اسم المستخدم
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Stack(
//               children: [
//                 Icon(Icons.message),
//                 if (_newMessagesCount > 0)
//                   Positioned(
//                     right: 0,
//                     child: Container(
//                       padding: EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       constraints: BoxConstraints(
//                         minWidth: 12,
//                         minHeight: 12,
//                       ),
//                       child: Text(
//                         '$_newMessagesCount',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             label: 'Chats',
//           ),
//           BottomNavigationBarItem(
//             icon: Stack(
//               children: [
//                 Icon(Icons.contacts),
//                 if (_newContactsCount > 0)
//                   Positioned(
//                     right: 0,
//                     child: Container(
//                       padding: EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       constraints: BoxConstraints(
//                         minWidth: 12,
//                         minHeight: 12,
//                       ),
//                       child: Text(
//                         '$_newContactsCount',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             label: 'Contacts',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.circle),
//             label: 'Status',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Color(0xff004170),
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//         onTap: _onItemTapped,
//         elevation: 10,
//       ),
//     );
//   }
// }