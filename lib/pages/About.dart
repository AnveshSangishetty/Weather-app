import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Developed by:",
              style: GoogleFonts.quicksand(fontSize: 30,fontWeight: FontWeight.w500),),
            Text("Anvesh Sangishetty",
              style: GoogleFonts.quicksand(fontSize: 30,fontWeight: FontWeight.w500),),
            Image.asset('assets/pass_photo.jpeg',height: 200,width: 200,),
            const SizedBox(height: 50,),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://drive.google.com/file/d/1dSefhh1VNqtoG7LOIm9Tli08oIiYO3mA/view?usp=drive_link')),
              child: const Text(
                'CV',
                style: TextStyle(fontSize:20,decoration: TextDecoration.underline, color: Colors.blue),
              ),
            ),
          const SizedBox(height: 5,),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/anvesh-sangishetty-4887951b6/')),
              child: const Text(
                'LinkedIn',
                style: TextStyle(fontSize:20,decoration: TextDecoration.underline, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 5,),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://github.com/AnveshSangishetty')),
              child: const Text(
                'GitHub',
                style: TextStyle(fontSize:20,decoration: TextDecoration.underline, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 5,),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://drive.google.com/file/d/1ihWYs4cbqKtXxTFqwzS1h93xl7rxiKre/view?usp=drive_link')),
              child: const Text(
                'Cover letter',
                style: TextStyle(fontSize:20,decoration: TextDecoration.underline, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20,),
            // Pop the page and navigate back to home page
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Back to home"))
          ],
        ),
      ),
    );
  }
}
