String tblContact = 'tbl_contact';
String tblContactColId = 'id';
String tblContactColName = 'name';
String tblContactColMobile = 'mobile';
String tblContactColEmail = 'email';
String tblContactColDesignation = 'designation';
String tblContactColCompany ='company';
String tblContactColAddress ='address';
String tblContactColWebsite = 'website';
String tblContactColFavorite ='favorite';


class ContactModel{
  int id;
  String name;
  String mobile;
  String email;
  String designation;
  String company;
  String address;
  String website;
  bool favorite;

  ContactModel({this.id=-1, required this.name, required this.mobile, this.email='', this.designation='',
      this.company='', this.address='', this.website='',this.favorite=false});

  Map<String, dynamic> toMap(){
    final map = <String, dynamic> {
      tblContactColName : name,
      tblContactColMobile : mobile,
      tblContactColEmail : email,
      tblContactColDesignation : designation,
      tblContactColCompany : company,
      tblContactColAddress : address,
      tblContactColWebsite : website,
      tblContactColFavorite : favorite? 1:0,


    };
    if(id>0){
      map[tblContactColId] = id;
    }
    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic>map)=>ContactModel(
    id: map[tblContactColId],
    name: map[tblContactColName],
    mobile: map[tblContactColMobile],
    email: map[tblContactColEmail],
    designation: map[tblContactColDesignation],
    company: map[tblContactColCompany],
    address: map[tblContactColAddress],
    website: map[tblContactColWebsite],
    favorite: map[tblContactColFavorite] == 1? true : false,
  );

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, mobile: $mobile, email: $email, designation: $designation, company: $company, address: $address, website: $website}';
  }
}