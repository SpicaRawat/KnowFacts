# KnowFacts

•    Shows fact about things

# INSTALLATION

•    Open Podfile from project directory.
•    Open terminal and cd to the directory containing the Podfile.
•    Run the "pod install" command.
•    Open xcworkspace 


# REQUIREMENT

•    Xcode : 11.3
•    Supported OS version: iOS (10.x,11.x, 12.x,13.x)


# LANGUAGE

•    Swift 5.0


# VERSION

•    1.0


# DESIGN PATTERN

•    MVVM
The Model View ViewModel (MVVM) is an architectural pattern. 

•    Model: 
A Model is responsible for exposing data in a way that is easily accessible. It manages and stores data received from server and core data.

•    View: 
View controllers come under this layer. View controller is responsible for laying out user interface and interact with users.

•    ViewModel: 
All business logics are handled in view model. View model is responsible to update model, based on events received from view and pass data to view to update UI elements for user action.


# LIBRARIES USED
•    Alamofire
•    OHHTTPStubs/Swift
•    SDWebImage

# LINTING
•    Integration of SwiftLint into an Xcode scheme to keep a codebase consistent and maintainable .
•    Install the swiftLint via brew and need to add a new "Run Script Phase" with:
if which swiftlint >/dev/null; then
swiftlint
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
•    .swiftlint.yml file is used for basic set of rules . It is placed inside the project folder.

# UNIT TESTING
•    Unit testing is done by using XCTest.
•    To run tests click Product->Test or (cmd+U)


# ASSUMPTIONS
•    App is designed for iPhones, iPads only.

# IMPROVEMENTS
•    UI could be done more interactive and user friendly.
•    UI Testing is not implemented.

# LICENSE
MIT License
Copyright (c) 2020
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

