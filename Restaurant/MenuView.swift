//
//  MenuView.swift
//  LittleLemonCap
//
//  Created by Illia Berezovskyi on 15/10/2023.
//

import SwiftUI
import Foundation

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let results = try? JSONDecoder().decode(MenuList.self, from: data)
                if let results = results {
                    for menuItem in results.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.category = menuItem.category
                    }
                    try? viewContext.save()
                }
            }
        }
        task.resume()
    }
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Boston")
            Text("We are a family-owned Mediterranean restaurant, focused on the traditional recipes served with a modern twist.")
            FetchedObjects(content: { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            Text("\(dish.title): \(dish.price)")
                            AsyncImage(url: URL(string: dish.image)) { phase in
                                if let image = phase.image {
                                        image // Displays the loaded image.
                                    } else if phase.error != nil {
                                        Color.red // Indicates an error.
                                    } else {
                                        ProgressView() // Acts as a placeholder.
                                    }
                            }
                            .frame(width: 100, height: 100)
                        }
                    }
                }
            })
        }
        .onAppear() {
            getMenuData()
        }
    }
}

#Preview {
    MenuView()
}
