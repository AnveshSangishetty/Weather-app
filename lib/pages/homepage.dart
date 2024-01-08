import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_apii/pages/weather_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text editing controllers for text-fields: City,Zip code
  TextEditingController cityNameController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  // Loading indicator
  bool isLoading = false;

  // Function to validate input of city name field
  int validationCheck(String name){
    // This conditional block checks whether any input is given/not
    if (name.length==0){
      Fluttertoast.showToast(msg: "Please enter city name");
      return 0;
    }
    // This conditional block checks whether input contains at least one alpha character
    RegExp regExp = RegExp(r'[a-zA-Z]');
    if(regExp.hasMatch(name)==false){
      Fluttertoast.showToast(msg: "City name should contain at least one alphabetic character");
      return 0;
    }
    // all validations passed, return 1
    return 1;
  }

  // Function to validate zipcode
  bool isValidZip(String zipcode){
    // Zipcodes can be 5 or 6 digits/ 5 digits followed by a hyphen, followed by 4 digits
    RegExp zipCodeRegExp = RegExp(r'(^\d{5,6}$)|(^\d{5}-\d{4}$)');
    if (zipCodeRegExp.hasMatch(zipcode)==false && zipcode.length>0){
      Fluttertoast.showToast(msg: "Ignoring zipcode",toastLength: Toast.LENGTH_LONG);
    }
    return zipCodeRegExp.hasMatch(zipcode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                  'Weather app',
                  style: GoogleFonts.quicksand(fontSize: 30,fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 100,),
            // Text field for city name input
            TextField(
              controller: cityNameController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
              ),
            ),
            // Text field for zip code input
            TextField(
              controller: zipCodeController,
              decoration: const InputDecoration(
                labelText: 'Enter zipcode (Optional)',
              ),
            ),
            const SizedBox(height: 20.0),
            // Submit button
            ElevatedButton(
              onPressed: isLoading ? null : () async {
                  // rebuild UI with loading indicator
                  setState(() {
                    isLoading = true;
                  });
                  String cityName = cityNameController.text;
                  String zipcode = zipCodeController.text;
                  // Clear the inputs
                  zipCodeController.text="";
                  cityNameController.text="";
                  // Check the internet connection
                  bool connection_result = await InternetConnectionChecker().hasConnection;
                  // Validations
                  var validation = validationCheck(cityName);
                  var zip_validation = isValidZip(zipcode);
                  // Create details list and pass it to weather page
                  List<String> details;
                  zip_validation==true?details=[cityName,zipcode]:details=[cityName];
                  if(connection_result==true){
                    if(validation==1){
                      // Navigate to WeatherPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherPage(details),
                        ),
                      );
                    }
                  }
                  else{
                    Fluttertoast.showToast(msg: "Please check your network connection");
                  }
                  setState(() {
                    isLoading = false;
                  });
                },
              // Button contains loading indicator if "isLoading" is true, else text "Submit"
              child: isLoading?
                  SizedBox(height:25,width:25,child: const CircularProgressIndicator(backgroundColor:Colors.black,color: Colors.white,))
                  :const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
