//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Mary Keefe on 2/1/21.
//

import SwiftUI

struct ExpenseItem : Identifiable, Codable {
    let name: String
    let type: String
    let amount: Int
    let id: UUID
}

class Expenses: ObservableObject {
    //@Published var items = [ExpenseItem]()
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}
