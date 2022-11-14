import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendImage extends StatefulWidget {
  const SendImage();

  @override
  _SendImageState createState() => _SendImageState();
}

class _SendImageState extends State<SendImage> {
  File img;
  final imgpic=new ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(

              height: 200,
              width: 400,
              margin: EdgeInsets.only(top: 40),
                child: img!=null?Image.file(File(img.path).absolute):Text("chose img")),
            MaterialButton(
              child: Text("pick image"),
              onPressed: picimg,),
            MaterialButton(
              child: Text("Upload"),
              onPressed: uploadimg,)

          ],
        ),

      ),
    );
  }
  picimg()async{
    final pickerfile=await imgpic.getImage(source: ImageSource.gallery);
    pickerfile!=null?

    setState(() {
      img=File(pickerfile.path);
    }):print("no image pickers");
  }
  Future uploadimg()async{
    var stream=new http.ByteStream(img.openRead());
    stream.cast();
    var length=await img.length();
    var uri=Uri.parse('http://192.168.1.107:51276/api/sendimages');
    var requst=new http.MultipartRequest('POST', uri);
    requst.fields['Nameimage']="Static title";
    var multipart=new http.MultipartFile(
        'img', stream, length);
    requst.files.add(multipart);
    var responce=await requst.send();
    responce.statusCode>=200&&responce.statusCode<300?print("done"):print("noy");

  }
}
