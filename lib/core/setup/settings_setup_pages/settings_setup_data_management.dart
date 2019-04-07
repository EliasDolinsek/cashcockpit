import 'package:cash_cockpit/core/data/data_provider.dart';
import 'package:flutter/material.dart';

class SettingsSetupDataManagement extends StatelessWidget {

  final DataProvider _dataProvider;

  SettingsSetupDataManagement(this._dataProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
        child: Column(
          children: <Widget>[
            Text(
              "DATA",
              style: TextStyle(fontSize: 48),
            ),
            Text(
              "Select your prefered data savage locations",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            Expanded(
              child: _DataSettingsSelection(_dataProvider),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("BACK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                RaisedButton(
                  child: Text(
                    "NEXT",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    //_showNextPage(context);
                  },
                  color: Theme
                      .of(context)
                      .primaryColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _DataSettingsSelection extends StatefulWidget {
  final DataProvider dataProvider;

  _DataSettingsSelection(this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _DataSettingsSelectionState();
  }
}

class _DataSettingsSelectionState extends State<_DataSettingsSelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 32.0,),
        CheckboxListTile(
          value: widget.dataProvider.settings.saveDataOnFirebase,
          onChanged: (value) {
            setState(() {
              _setDataSavageLocation(value);
            });
          },
          title: Text("Save data on server"),
          subtitle: Text(
              "Your data will be saved on the server and synchronized between all your devices. If you disable this setting, all your data is saved locally and realtime synchronizeation is disabled."),
        ),
        SizedBox(height: 32.0,),
        CheckboxListTile(
          value: widget.dataProvider.settings.saveImageLocallyOnly,
          onChanged: _getOnImageSavageLocationCheckboxChanged(),
          title: Text("Save images locally only"),
          subtitle: Text(
              "Images will be saved locally only and won't be synchronized between your devices. "),
        ),
      ],
    );
  }

  Function _getOnImageSavageLocationCheckboxChanged() =>
      widget.dataProvider.settings.saveDataOnFirebase ? (value) {
        setState(() {
          _setImageSavageLocation(value);
        });
      } : null;

  void _setDataSavageLocation(bool saveDataOnFirebase) {
    var settings = widget.dataProvider.settings;
    settings.saveDataOnFirebase = saveDataOnFirebase;
    widget.dataProvider.changeSettings(settings);
  }

  void _setImageSavageLocation(bool saveImagesLocallyOnly) {
    var settings = widget.dataProvider.settings;
    settings.saveImageLocallyOnly = saveImagesLocallyOnly;
    widget.dataProvider.changeSettings(settings)
  }
}
