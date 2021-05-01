import 'package:flutter/material.dart';
class SettingFragment extends StatefulWidget {
  @override
  _SettingFragmentState createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SETTINGS",style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,),),
      ),
          body: Column(
            children: <Widget>[
              // Avatar
              Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[
//                      (avatarImageFile == null)
//                          ? (photoUrl != ''
//                          ? Material(
//                        child: CachedNetworkImage(
//                          placeholder: (context, url) => Container(
//                            child: CircularProgressIndicator(
//                              strokeWidth: 2.0,
//                              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                            ),
//                            width: 90.0,
//                            height: 90.0,
//                            padding: EdgeInsets.all(20.0),
//                          ),
//                          imageUrl: photoUrl,
//                          width: 90.0,
//                          height: 90.0,
//                          fit: BoxFit.cover,
//                        ),
//                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
//                        clipBehavior: Clip.hardEdge,
//                      )
//                          : Icon(
//                        Icons.account_circle,
//                        size: 90.0,
//                        color: greyColor,
//                      ))
//                          : Material(
//                        child: Image.file(
//                          avatarImageFile,
//                          width: 90.0,
//                          height: 90.0,
//                          fit: BoxFit.cover,
//                        ),
//                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
//                        clipBehavior: Clip.hardEdge,
//                      ),
                      IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.blueGrey.withOpacity(0.5),
                        ),
                        onPressed: (){},
                        padding: EdgeInsets.all(30.0),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.blueGrey,
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ),
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
              ),

              // Input
              Column(
                children: <Widget>[
                  // Username
                  Container(
                    child: Text(
                      'Nickname',
                      style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                    margin: EdgeInsets.only(left: 10.0, bottom: 5.0, top: 10.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context).copyWith(primaryColor: Colors.blueGrey),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '_',
                          contentPadding: new EdgeInsets.all(5.0),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        // controller: controllerNickname,
                        onChanged: (value) {
                          //  nickname = value;
                        },
                        // focusNode: focusNodeNickname,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  ),

                  // About me
                  Container(
                    child: Text(
                      'Username',
                      style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                    margin: EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context).copyWith(primaryColor: Colors.grey),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '_',
                          contentPadding: EdgeInsets.all(5.0),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        // controller: controllerAboutMe,
                        onChanged: (value) {
                          //aboutMe = value;
                        },
                        // focusNode: focusNodeAboutMe,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),

              // Button
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text(
                    'UPDATE',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  color: Colors.blueGrey[900],
                  highlightColor: new Color(0xff8d93a0),
                  splashColor: Colors.transparent,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                ),
                margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  color: Colors.blueGrey[900],
                  highlightColor: new Color(0xff8d93a0),
                  splashColor: Colors.transparent,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                ),
                margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              ),
            ],
          ),
    );
  }
}
