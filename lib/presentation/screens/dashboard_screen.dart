import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_test/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:test_test/data/repos/rest_repo.dart';
import 'package:test_test/presentation/widgets/base_button.dart';
import 'package:test_test/presentation/widgets/custom_text_input.dart';
import 'package:test_test/presentation/widgets/error_alert.dart';
import 'package:test_test/presentation/widgets/page_loading.dart';
import 'package:test_test/utils/date_picker.dart';


class DashboardScreen extends StatelessWidget{
  final TextEditingController firstNameTextEditController = new TextEditingController();
  final TextEditingController lastNameTextEditController = new TextEditingController();
  final FocusNode lastNameFocusNode = new FocusNode();
  final TextEditingController ageTextEditController = new TextEditingController();
  final FocusNode ageFocusNode = new FocusNode();
  final TextEditingController documentNumberTextEditController = new TextEditingController();
  final FocusNode documentFocusNode = new FocusNode();

  @override
  Widget build(BuildContext cont) {
    return BlocProvider<DashBoardBloc>(
      create: (BuildContext context) => DashBoardBloc(restRepos: context.read<RestRepos>())..add(DashboardInitEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ShuftiPro Demo",
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<DashBoardBloc, DashboardState>(
          listener: (context, state){
            if (state is DashboardErrorState) {
              errorAlert(context: context, header: state.header, message: state.message);
            }
          },
          buildWhen: (prevState, currentState) {
            if (currentState is DashboardErrorState) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is DashboardMainState) {
              return Padding(
                padding: EdgeInsets.only(top:12, left: 16, right: 16, bottom: 4),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Expanded(
                          child: new ListView(
                            children: [
                              new CustomTextInput(
                                textEditingController: firstNameTextEditController,
                                hintText: "First name",
                                icon: Icon(Icons.account_circle_outlined),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (){
                                  FocusScope.of(context).requestFocus(lastNameFocusNode);
                                },
                              ),
                              new SizedBox(height: 10,),
                              new CustomTextInput(
                                textEditingController: lastNameTextEditController,
                                hintText: "Last Name",
                                icon: Icon(Icons.account_circle_outlined),
                                textInputAction: TextInputAction.next,
                                focusNode: lastNameFocusNode,
                                onFieldSubmitted: (){
                                  FocusScope.of(context).requestFocus(ageFocusNode);
                                },
                              ),
                              new SizedBox(height: 10,),
                              new CustomTextInput(
                                textEditingController: ageTextEditController,
                                hintText: "Age",
                                icon: Icon(Icons.calendar_month),
                                focusNode: ageFocusNode,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (){
                                  FocusScope.of(context).requestFocus(documentFocusNode);
                                },
                              ),
                              new SizedBox(height: 10,),
                              new CustomTextInput(
                                textEditingController: documentNumberTextEditController,
                                hintText: "Document number",
                                icon: Icon(Icons.add_card_outlined),
                                focusNode: documentFocusNode,
                                textInputAction: TextInputAction.done,
                              ),
                              new SizedBox(height: 10,),
                              new BaseOutlineButton(
                                  buttonText: "Date of Birth",
                                  height: 48,
                                  onTap: (){
                                    selectDate(context , (DateTime selectedDate) {
                                      BlocProvider.of<DashBoardBloc>(context).add(SetBirthDayDateDashboardEvent(selectedDate));
                                    });
                                  },
                              ),
                              new SizedBox(height: 10,),
                              new BaseOutlineButton(
                                buttonText: "Issue Date",
                                height: 48,
                                onTap: (){
                                  selectDate(context, (DateTime selectedDate) {
                                    BlocProvider.of<DashBoardBloc>(context).add(SetIssueDateDashboardEvent(selectedDate));
                                  }
                                  );
                                },
                              ),
                              new SizedBox(height: 10,),
                              new BaseOutlineButton(
                                buttonText: "Expiry Date",
                                height: 48,
                                onTap: (){
                                  selectDate(context, (DateTime selectedDate) {
                                    BlocProvider.of<DashBoardBloc>(context).add(SetExpiryDatDashboardEvent(selectedDate));
                                  });
                                },
                              ),
                              new SizedBox(height: 20,),
                              new BaseOutlineButton(
                                buttonText: "Pick Passport Photo",
                                height: 48,
                                onTap: () async {
                                  BlocProvider.of<DashBoardBloc>(context).add(LoadImageDashboardEvent());
                                },
                              ),
                            ],
                          ),
                        ),
                        new BaseButton(
                          buttonText: "Send Data",
                          width: 300,
                          height: 50,
                          onTap: (){
                            BlocProvider.of<DashBoardBloc>(context).add(
                                SendInfoDashboardEvent(
                                    firstName: firstNameTextEditController.text,
                                    lastName: lastNameTextEditController.text,
                                    age: ageTextEditController.text,
                                    documentNumber: documentNumberTextEditController.text,
                                ));
                          },
                        )
                      ],
                    ),
                    state.sendDataLoading ? pageLoader() : Center(),
                  ],
                ),
              );
            }
            return Center();
          }
        ),
      ),
    );
  }

}