# PopcornApp

  

### Project

 Run `pod install` and open `xcworkspace` to build the preoject
 
I started the project by understanding the design and the flow. The first problem I faced here because the data for some parts of the design were missing. I put some placeholders and random data there.
The images were also very big and I had to create a `func resizeImage(size: CGSize) -> UIImage` to make the images smaller, otherwise the layout gets messed up.
First I implemented the logic part and then the UI of the application

### Arhitecture
I used MVVM architecture in the project. 
For navigation I used flow controllers.
The project was started from our company project skeleton with some helper classes already provided

 - **Logic** - communication with api, data handling and storage
 - **User Interface**:
     - Component - childs of basic UI componens
     - Flows - flow controller and its contents

### Libraries
- **RestBird** - Lightweight, stateless REST network manager over the Codable protocol built upon Alamofire and I used to make the api request.
- **[Kingfisher](https://github.com/onevcat/Kingfisher)** - loading images easily
- **[RxSwift](https://github.com/ReactiveX/RxSwift)** - communication between data handlers -> view models and view models -> UI
- **https://github.com/SwiftGen/SwiftGen** - generates code from localizable strings, assets and colors

### Time
It took me a little more than 1 day.
