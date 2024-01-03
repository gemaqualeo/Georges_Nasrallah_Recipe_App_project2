import 'package:flutter/material.dart';


class choseRecipe extends StatelessWidget {
   choseRecipe({super.key, required this.data});
  List<dynamic> data = ([]);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title:  Text(data[0]),
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child:Container(
              padding: const EdgeInsets.all(5),
              height: 90,
              child: Row (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10),
                          image: DecorationImage(
                            scale: 1,
                            image: NetworkImage(
                                data[2]),
                          ),
                        )
                    ),
                    const SizedBox(width: 10, height: 10),
                    Expanded(child:
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('this recipe takes a total of ', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight:FontWeight.w400 ),),
                            Text(data[1],  style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight:FontWeight.w400 ),),

                             const Text('This Recipe has a total of ',  style:  TextStyle(fontSize: 14, color: Colors.black, fontWeight:FontWeight.w400),),
                              Text(data[3], style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight:FontWeight.w400 ),),
                  ]
              ),)
               ]

            ),
          )
      ));


    }
  }

