import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiting_card/pages/form_page.dart';
import 'package:visiting_card/providers/contact_provider.dart';

class HomePage extends StatefulWidget {
  static const String routename='/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex= 0;
  bool isFirst=true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(isFirst){
      Provider.of<ContactProvider>(context,listen:false).getAllContacts();
    }
    isFirst=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, FormPage.routename);
        },
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),


      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: (index){
            setState(() {
              selectedIndex= index;
            });
          },
          currentIndex: selectedIndex,
          backgroundColor: Colors.blueGrey.shade100,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: 'All'
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                label: 'Favourite'
            ),
          ],
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, _) {
          if(provider.contactlist.isEmpty)
          {
            return const Center(child: Text('Nothing to show'),);
          }
          return ListView.builder(
            itemCount: provider.contactlist.length,
            itemBuilder: (context, index) {
              final contact= provider.contactlist[index];
              return ListTile(
                title: Text(contact.name),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(contact.favourite? Icons.favorite: Icons.favorite_border),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
