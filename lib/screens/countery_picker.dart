import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController _searchController = TextEditingController();
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {
      // No need to update the _selectedCountry when the search text changes.
      // Only update the search text in this method.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Combine the selected country name with the search text.
    String searchText = _selectedCountry != null
        ? '${_selectedCountry!.name} - ${_searchController.text}'
        : _searchController.text;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search and Dropdown'),
      ),
      body: Padding(

        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xff211A2c),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, color:Color(0xff88B172)), // Set icon color
                onPressed: () {
                  // Perform search action using searchText
                },
              ),
              Expanded(
                child: TextField(
                
                  controller: _searchController,
                  style: TextStyle(color: Colors.grey), // Set text color
                  decoration: InputDecoration(
                    
                    filled: true,
                    fillColor: Color(0xff211A2c),
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey), // Set hint text color
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
              IconButton(
              
                icon: Icon(Icons.arrow_drop_down, color: Color(0xff88B172)), // Set icon color
                onPressed: () {
                  _openCountryPicker();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
          _searchController.clear();
          _searchController.text = '${country.name} - ${_searchController.text}';
        });
      },
    );
  }
}
