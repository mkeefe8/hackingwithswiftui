//
//  ContentView.swift
//  iExpense
//
//  Created by Mary Keefe on 1/31/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline).fontWeight(.heavy)
                            
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                    //.listRowBackground(Color.red)
                    .modifier(ListItemModifier(amount: item.amount))
                }
                .onDelete(perform: removeItems)
            
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading:
                                    Button(action: {
                                        // let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5, id: UUID())
                                        //  self.expenses.items.append(expense)
                                        self.showingAddExpense = true
                                        
                                    }) {
                                        Image(systemName: "plus")
                                    }, trailing: EditButton()
                                        .sheet(isPresented: $showingAddExpense) {
                                            AddView(expenses: expenses)
                                        }
            )
        }
        
    }
    
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    struct ListItemModifier: ViewModifier {
        let amount : Int
        
        func body(content: Content) -> some View {
           /*
            if amount <= 10 {
                return content.listRowBackground(Color.green)
            }
 */
           // return content.listRowBackground(Color.yellow)
 
            
            switch amount {
            case 1...10:
                return content.listRowBackground(Color.green)
            case 11...100:
                return content.listRowBackground(Color.yellow)
            default:
                return content.listRowBackground(Color.red)
            }
        }
    }
}


struct ContentView2: View {
    @State var listItems = [Item]()
    
    @State var addItemName: String = ""
    
    @State var colorSelection: UIColor = UIColor.systemRed
    
    @State var addItem = false
    
    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    List {
                        ForEach(listItems, id: \.self) { item in
                            Text(item.name).listRowBackground(Color(item.color))
                        }
                    }
                    .navigationBarTitle(Text("List Items"))
                    // Adds the plus button to our navbar
                    .navigationBarItems(trailing:
                                            Button(action: {
                                                // toggles the value of our bool from false to true,
                                                // which will present our sheet.
                                                self.addItem.toggle()
                                            }, label: {
                                                Image(systemName: "plus")
                                            })
                                        
                    )
                    // This is our secondary view that'll take in our user's input.
                    // Is presented when addItem is set to true.
                }.sheet(isPresented: $addItem) {
                    VStack {
                        HStack {
                            Text("Item Name: ")
                            TextField("Add an Item", text: self.$addItemName)
                        }
                        // A simple picker that gives our user some different selections of color.
                        Picker(selection: self.$colorSelection, label: Text("Select a Color")) {
                            Text("Red").tag(UIColor.systemRed)
                            Text("Blue").tag(UIColor.systemBlue)
                            Text("Green").tag(UIColor.systemGreen)
                            Text("Yellow").tag(UIColor.systemYellow)
                        }
                        // Button that will submit our data to the list and reset our user selected
                        // variables for when then add another item.
                        Button(action: {
                            self.listItems.append(Item(name: self.addItemName, color: self.colorSelection))
                            
                            // This will close our sheet view when the user click our Add button.
                            self.addItem.toggle()
                            
                            // Reset Values
                            self.addItemName = ""
                            self.colorSelection = UIColor.systemRed
                        }, label: {
                            Text("Add")
                        })
                    }.padding(100)
                }
                
            }
        }
    }
    
    struct Item: Hashable {
        let name: String
        let color: UIColor
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
