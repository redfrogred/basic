# NOTES 
This is a place for stuff that doesn't fit under README

## BRANCH NAMES
"main"   
+ This will have the latest stuff I am working on. (With all branches combined)

"basic"
+ This just has navigation and two pages (Start and End).

"enhanced1"   
+ "basic" plus Provider package, plus a Config that has some simple app info and styling   

"stored2"   
+ "enhanced" plus "shared_preferences" package (and "Stored" class)

"sound3"   
+ "stored" plus sound package and class


## GENERAL IDEAS
NAMING CONVENTIONS   
* variables be "lowercase_with_hyphens"   
* methods be "camelCased()"...  
* classes will be capitalized, and always have the filename exactly match the class name (so the "Config" class is "Config.dart", for instance)

KEYBOARD INPUT
For debugging, I am using phsycial keyboard input. See:
https://blog.gskinner.com/archives/2021/04/flutter-accelerate-your-testing-with-keyboard-listeners.html
Basically, in Controller, if kDebug AND Config.keyboard_listener == true, each keypress calls "_handleKeyDown()" which examines if a key should do something (like toggle debug mode).





