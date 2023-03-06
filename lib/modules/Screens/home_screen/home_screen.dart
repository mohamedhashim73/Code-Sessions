import 'package:code_app/layout/layout_cubit/layout_cubit.dart';
import 'package:code_app/layout/layout_cubit/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/style/colors.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(title: const Text("Fashion store"),elevation:0,backgroundColor: Colors.transparent,foregroundColor: mainColor,),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      enabled: false,
                      onChanged: (input)
                      {

                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.3),
                          suffixIcon: InkWell(
                            onTap: (){},
                            child: Icon(Icons.clear),
                          ),
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  cubit.bannersData.isEmpty ?
                      const SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: CircularProgressIndicator(),
                      ) :
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: PageView.builder(
                        itemCount: cubit.bannersData.length,
                        itemBuilder: (context,index){
                          return Image.network(cubit.bannersData[index].image!,width: double.infinity,height: double.infinity,);
                        }
                    ),
                  ),
                  Row(
                    children:
                    [
                      Text("Categories",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 18),),
                      Spacer(),
                      Text("View All"),
                    ],
                  ),
                  SizedBox(height: 10,),
                  state is GetCategoriesLoadingState ?
                  CircularProgressIndicator() :
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: cubit.categoriesData.length,
                        itemBuilder: (context,index)
                        {
                          return Container(
                            margin: EdgeInsets.only(right: 15),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(cubit.categoriesData[index].image!),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
