[![Platforms](https://img.shields.io/badge/platform-iOS-yellow.svg)]()
[![Language](https://img.shields.io/badge/language-Swift_5.0-orange.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()

# ⭐️ LiteStarView

## About 

Leave a ⭐ if you like this project or want to see updates in future.

The view was designed for a recipe app. I needed a simple ratings view that was also setable by the user and would work in a collection view.

## 📑 Description

A light weight star rating UI component for iOS written in Swift. 

![alt text](ReadmePic/starShot.png "User Interaction Enabled")
![alt text](ReadmePic/starFloat.gif "Float")
![alt text](ReadmePic/starInt.gif "Int")

# 📐 Design

StarView is a minimalist design, with a few customizations. 

**Note**: *This view is not currently IBDesignable*

### Features 

- Can be used to show ratings followed by number of ratings.
- If `isUserInteractionEnabled` user can provied a rating by panning or tapping on stars, rating will be shown.
- Gives haptic Feedback when user selects/deselect one full star
- Round stars to the nears whole 

### Modifiers / Customization

Variables you can modifiy in the view inspectinable with type and default value. 
                   
- `starCount:Int = 5`                                                 : Number of stars in view  
- `ratingCount:Int = 0`                                             : Amount of ratings for item
- `rating:CGFloat = 0.0`                                           : Rating for item
- `roundRating:Bool = false`                                   : Will use whole numbers in rating
- `fillColor:UIColor = UIColor.systemYellow`  : Star fill color
- `stokeColor` :`UIColor = UIColor.black`             : Star outline (strokeColor) color 


# 🎲 Behavior

### Updating the view

Stars are automaticity update when when the `rating` or `ratingCount` changes. 
Also calling `starView.updateStar()` will force a update. So make your changes before calling!


# 🏗 Installation 

### Manually 

Git clone the repo and add LiteStarView framework to your exsiting xcode project. 

**Note:** *You might need build the framework.*

[How to add LiteStarView framework to a existing project. ](https://youtu.be/xE_Q32SOAfo "Video demo of add framework ")

### CocoaPods

Add the following in your Podfile.

`'LiteStarView', '~> 1.0'`


# 📋 Setup

### 1. Create StarView

Create and drop a UIView then set the class to StarView.

<img src="ReadmePic/setClass.png" height="90" alt="class"/>

### 2. Set your constraints

There are many way to layout this view but a height constraint is needed for the stars to be drawn correctly. Take a look at the examples below

 This is the formula to help calculate the width.
 
`(height * amountOfStars) + (height * 2)`

 **Examples**
 
 <img src="ReadmePic/alignLeft.png" height="70" alt="constraints"/>
 
<img src="ReadmePic/constraints.png" height="250" alt="constraints"/>


---

<img src="ReadmePic/starDemoCenter.png" height="70" alt="constraints"/>

<img src="ReadmePic/alignCenter.png" height="250" alt="constraints"/>

**Note:** *Also need to set Center Horizontal in Safe Area to the parent.*

**Formula Example:**  `(40 * 5) + (40 * 2) = 280`


### 3. The view can be set up in one of two ways.

**- Show rating (Non-interactive)**

<img src="ReadmePic/userDisabled.png" height="50" alt="class"/>

![alt text](ReadmePic/starShot.png "User Interaction Enabled")

**- User provided rating (interactive)**

<img src="ReadmePic/userEnabled.png" height="50" alt="class"/>

![alt text](ReadmePic/starFloat.gif "Float")
![alt text](ReadmePic/starInt.gif "Int")

### 4. Using StarView

Once linked to your viewController. You can programmatically set/get rating and rating counter. 


```swift

import UIKit
import LiteStarView
class ViewController: UIViewController {

    @IBOutlet weak var starView: StarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set rating and ratingCount programmable
        starView.rating = 3.5
        starView.ratingCount = 50
        // get current rating
        let currentRating = starView.rating
    }
}

```



