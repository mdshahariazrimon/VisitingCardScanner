import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiting_card/models/contact_model.dart';
import 'package:visiting_card/providers/contact_provider.dart';
import 'package:visiting_card/utils/helpers.dart';

class FormPage extends StatefulWidget {
  static const String routename='/form';
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        actions: [
          IconButton(
            onPressed: _saveContact,
            icon: const Icon(Icons.save),
          )
        ],
      ),

      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Contact Name',
                  filled: true,
                ),
                validator: (value){
                  if(value==null || value.isEmpty)
                  {
                    return 'This Field must not be empty';
                  }
                  if(value.length>30)
                  {
                    return 'Name Should not be more than 30 chars long';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: mobileController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.call),
                  labelText: 'Contact Number',
                  filled: true,
                ),
                validator: (value){
                  if(value==null || value.isEmpty)
                  {
                    return 'This Field must not be empty';
                  }
                  /*if(value.length!=11)
                  {
                    return 'Mobile number must be 11 digit long';
                  }*/
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email Address',
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                controller: companyController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.label),
                  labelText: 'Company Name',
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                controller: designationController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.label),
                  labelText: 'Designation',
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_city),
                  labelText: 'Address',
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.url,
                controller: websiteController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.web),
                  labelText: 'Website',
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact() async {
    if(formkey.currentState!.validate())
    {
      final contact = ContactModel(
        name: nameController.text,
        mobile: mobileController.text,
        email: emailController.text,
        company: companyController.text,
        designation: designationController.text,
        address: addressController.text,
        website: websiteController.text,
      );
      Provider.of<ContactProvider>(context,listen: false)
          .insertContact(contact)
          .then((rowId){
        if(rowId>0)
        {
          showMsg(context, 'Saved');
          Navigator.pop(context);
        }
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    companyController.dispose();
    designationController.dispose();
    addressController.dispose();
    websiteController.dispose();
    super.dispose();
  }
}
