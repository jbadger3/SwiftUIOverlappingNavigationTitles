//
//  ContentView.swift
//  OverlappingNavigationTitles
//
//  Created by Jonathan Badger on 12/1/20.
//
/*
 To see phenomenon where navigation titles persist in the UI and overlap:
 1. Start a live preview in the Canvas
 2. Select one of the food groups (fruit or vegetables) to move to the DetailView screen
 3. Scroll down so that the large title text shrinks and is pushed up into the navigation bar
 4.  Tap either the cancel or save button
 If you don't see the behavior on your first try go back and forth between screens repeating 2-4
 */

import SwiftUI

struct FoodGroup {
    var name: String
    var examples: [String]
}

struct ContentView: View {
    var foodGroups: [FoodGroup] {
        let fruits = FoodGroup(name: "Fruits", examples: ["Apple", "Banana", "Pear", "Peach", "Mango", "Orange", "Strawberry", "Watermelon", "Pineapple", "Lemon", "Lime", "Cherry", "Date", "Plum", "Apricot", "Blueberry", "Blackberry", "Cranberry", "Kiwi", "Nectarine"])
        let vegetables = FoodGroup(name: "Vegetables", examples: ["Lettuce", "Carrot", "Beet", "Broccoli", "Corn", "Celery", "Chicory", "Kale", "Spinach", "Yarrow", "Brussels sprouts", "Arugula", "Cauliflower", "Turnip", "Sweet Potato"])
        return [fruits, vegetables]
    }
    
    @State var isDetailLink = true

    var body: some View {
        NavigationView {
            List {
                ForEach(foodGroups, id: \.name) { foodGroup in
                    NavigationLink(
                        destination: DetailView(foodGroup: foodGroup),
                        label: {
                            Text(foodGroup.name)
                        })
                        .isDetailLink(isDetailLink)
                }
                Button(action: {isDetailLink.toggle()}, label: {
                        Text("Detail link: \(String(isDetailLink))")
                })
                .buttonStyle(BorderlessButtonStyle())

            }
            .navigationTitle(Text("Food Groups"))
        }
    }
}

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var foodGroup: FoodGroup
    @State var navDisplayMode: NavigationBarItem.TitleDisplayMode = .large
    var body: some View {
        Form {
            ForEach(foodGroup.examples, id: \.self) { foodName in
                Text(foodName)
            }
            Button(action: {
                if navDisplayMode == .large {
                    navDisplayMode = .inline
                } else {
                    navDisplayMode = .large
                }
            }, label: {
                Text("Nav Display Mode: \(navDisplayMode == .large ? "large" : "inline")")
            })
            HStack {
                Spacer()
                Button(action: {dismissView()}, label: {
                        Text("Save")
                    })
                Spacer()
            }
        }
        .navigationBarTitle(foodGroup.name, displayMode: navDisplayMode)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {self.dismissView()}, label: {
            Text("Cancel")
        }))
    }
    
    func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
