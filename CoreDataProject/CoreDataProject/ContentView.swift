//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Mary Keefe on 2/11/21.
//

import SwiftUI

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    
    var body: some View {
        VStack {
           // FilteredList(filter: lastNameFilter)
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }
            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
    
    
    
    struct FilteredList<T: NSManagedObject, Content: View>: View {
        var fetchRequest: FetchRequest<T>
        var singers: FetchedResults<T> { fetchRequest.wrappedValue }

        // this is our content closure; we'll call this once for each item in the list
        let content: (T) -> Content

        var body: some View {
            List(fetchRequest.wrappedValue, id: \.self) { singer in
                self.content(singer)
            }
        }

        init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
            fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
            self.content = content
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
