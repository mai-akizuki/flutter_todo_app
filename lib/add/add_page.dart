import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main_model.dart';

class AddPage extends StatelessWidget {
  final MainModel model;
  AddPage(this.model);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>.value(
      value: model,
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規追加'),
        ),
        body: Consumer<MainModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "追加するTODO",
                      hintText: "ゴミを出す",
                    ),
                    onChanged: (text) {
                      model.newtodoText = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    child: Text('追加する'),
                    onPressed: () async {
                      await model.add();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
