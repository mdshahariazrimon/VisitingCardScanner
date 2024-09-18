import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:visiting_card/models/contact_model.dart';
import 'package:visiting_card/providers/contact_provider.dart';
import 'package:visiting_card/utils/helpers.dart';

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
                  ),
                  ListTile(
                    title: Text(contact.mobile),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: (){
                            _smsContact(contact.mobile);
                          },
                          icon: const Icon(Icons.sms),
                        ),
                        IconButton(
                          onPressed: (){
                            _callContact(contact.mobile);
                          },
                          icon: const Icon(Icons.call),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(contact.email.isEmpty?'No Data':contact.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: (){
                            _smsContact(contact.email);
                          },
                          icon: const Icon(Icons.email),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(contact.address.isEmpty?'No Data':contact.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: (){
                            _smsContact(contact.address);
                          },
                          icon: const Icon(Icons.map),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(contact.website.isEmpty?'No Data':contact.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: (){
                            _smsContact(contact.website);
                          },
                          icon: const Icon(Icons.web),
                        ),
                      ],
                    ),
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

  void _smsContact(String mobile) async {
    final url='sms: $mobile';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }
    else{
      showMsg(context, 'Can not perform this task');
    }
  }

  void _callContact(String mobile) async{
    final url='tel: $mobile';
    if(await canLaunchUrlString(url)){
    await launchUrlString(url);
    }
    else{
    showMsg(context, 'Can not perform this task');
    }
  }
}