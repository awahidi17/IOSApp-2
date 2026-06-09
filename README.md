# iOSApp2 - Scavenger Hunt App

## Created By

Ahmad Wahidi

## Course Information

**Course Code:** MWD3A
**Course Name:** iOS Development
**Assignment:** Assignment 3

## Project Description

Scavenger Hunt is an iOS application developed using SwiftUI and the MVVM architecture pattern. The application allows users to participate in a city-wide scavenger hunt by visiting local businesses, viewing clues, finding hidden items, and taking photos as proof of discovery.

The application tracks user progress and provides rewards based on the number of items found.

## Features

* Display 10 scavenger hunt items
* View clues for each item
* Navigate through multiple screens using NavigationStack
* Mark items as found
* Take or select photos using the device camera or photo library
* Track progress throughout the hunt
* Calculate rewards automatically
* Submit hunt results
* Custom SwiftUI views
* MVVM architecture

## Reward System

| Items Found | Reward                                |
| ----------- | ------------------------------------- |
| 0 - 4       | No Reward                             |
| 5 - 6       | 10% Discount Code                     |
| 7 - 9       | 20% Discount Code                     |
| 10          | 20% Discount Code + Grand Prize Entry |

## Project Structure

### Model

* HuntItem

### ViewModel

* HuntViewModel

### Views

* HomeView
* HuntListView
* ItemDetailView
* ResultsView
* ItemRowView
* CameraView

## Technologies Used

* Swift
* SwiftUI
* UIKit
* MVVM Architecture
* Xcode
* Git
* GitHub

## How to Run

1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the application on an iOS Simulator or physical device.
4. Navigate through the scavenger hunt screens and test the functionality.

## GitHub Repository

Repository: IOSApp-2

## Notes

This project was created for educational purposes as part of the MWD3A iOS Development course. The focus of the assignment was to demonstrate SwiftUI development concepts including navigation, state management, camera integration, data models, custom views, and MVVM architecture.
