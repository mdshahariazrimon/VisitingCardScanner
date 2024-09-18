import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiting_card/models/contact_model.dart';
import 'package:visiting_card/pages/contact_details_page.dart';
import 'package:visiting_card/pages/form_page.dart';
import 'package:visiting_card/providers/contact_provider.dart';
import 'package:visiting_card/utils/helpers.dart';

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
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: const EdgeInsets.only(right: 20),
                  alignment: FractionalOffset.centerRight,
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                confirmDismiss: _showConfirmationDialog,
                onDismissed: (direction) async{
                  await provider.deleteContact(contact.id);
                  showMsg(context, 'Deleted');
                },
                //favourite
                child: ListTile(
                  onTap: ()=> Navigator.pushNamed(context, ContactDetailsPage.routename,arguments: contact.id),
                  title: Text(contact.name),
                  trailing: IconButton(
                    onPressed: (){
                      provider.updateContactField(contact,tblContactColFavourite);
                    },
                    icon: Icon(contact.favourite? Icons.favorite: Icons.favorite_border),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(DismissDirection direction) {
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Delete Contact'),
      content: const Text('Are you sure to delete this contact?'),
      actions: [
        OutlinedButton(
          onPressed: (){
            Navigator.pop(context,false);
          },
          child: const Text('NO'),
        ),
        OutlinedButton(
          onPressed: (){
            Navigator.pop(context,true);
          },
          child: const Text('YES'),
        )
      ],
    ));
  }
}
