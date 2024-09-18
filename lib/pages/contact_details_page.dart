import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiting_card/models/contact_model.dart';
import 'package:visiting_card/providers/contact_provider.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routename='/details';
  const ContactDetailsPage({super.key});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  int id=0;
 
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    id= ModalRoute.of(context)?.settings.arguments as int;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider,child)=>FutureBuilder(
          future: provider.getContactByID(id),
          builder: (context,snapshot){
            if(snapshot.hasData){
              final contact=snapshot.data!;
              return ListView(
                children: [
                  Image.asset(contact.image,width: double.infinity,height: 250,fit: BoxFit.cover,),
                  ListTile(
                    title: Text(contact.name),
                  )
                ],
              );
            }
            if(snapshot.hasError){
              return const Center(child:Text('Failed to fetch data') ,);
            }
            return const Center(child: Text('Please Wait'),);
          },
        )
      ),
    );
  }
}