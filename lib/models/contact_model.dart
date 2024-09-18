const String tableContact= 'tbl_contact';
const String tblContactColId= 'id';
const String tblContactColName= 'name';
const String tblContactColMobile= 'mobile';
const String tblContactColEmail= 'email';
const String tblContactColAddress= 'address';
const String tblContactColWebsite= 'website';
const String tblContactColCompany= 'company';
const String tblContactColDesignation= 'designation';
const String tblContactColFavourite= 'favourite';
const String tblContactColImage= 'image';
class ContactModel{
  int id;
  String name;
  String mobile;
  String email;
  String company;
  String designation;
  String address;
  String website;
  bool favourite;
  String image;

  ContactModel({
    this.id=-1,
    required this.name,
    required this.mobile,
    this.email='',
    this.company='',
    this.designation='',
    this.address='',
    this.website='',
    this.favourite=false,
    this.image='images/car.png',
  });

  Map<String,dynamic>toMap()
  {
    final map= <String,dynamic>{
      tblContactColName: name,
      tblContactColMobile: mobile,
      tblContactColEmail:email,
      tblContactColCompany:company,
      tblContactColDesignation:designation,
      tblContactColAddress:address,
      tblContactColWebsite:website,
      tblContactColImage: image,
      tblContactColFavourite:favourite? 1:0,
    };
    if(id>0){
      map[tblContactColId]=id;
    }
    return map;
  }

  factory ContactModel.formMap(Map<String, dynamic>map)=> ContactModel(
    id: map[tblContactColId],
    name: map[tblContactColName],
    email: map[tblContactColEmail],
    mobile: map[tblContactColMobile],
    address: map[tblContactColAddress],
    company: map[tblContactColCompany],
    designation: map[tblContactColDesignation],
    website: map[tblContactColWebsite],
    image: map[tblContactColImage],
    favourite: map[tblContactColFavourite]==1?true:false,
  );

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, mobile: $mobile, email: $email, company: $company, designation: $designation, address: $address, website: $website, favourite: $favourite, image: $image}';
  }
}