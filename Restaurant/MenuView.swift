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
    
    @State var loaded = false
    @State var searchText = ""
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare))
        ]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Boston")
            Text("We are a family-owned Mediterranean restaurant, focused on the traditional recipes served with a modern twist.")
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            VStack {
                                Text("\(dish.title)")
                                    .bold()
                                Spacer()
                                Text("\(dish.descriptionDish)")
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Text("\(dish.price)")
                                    .font(.callout)
                            }
                            .frame(alignment: .leading)
                            Spacer()
                            AsyncImage(url: URL(string: dish.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                } else if phase.error != nil {
                                    Color.red // Indicates an error.
                                        .frame(width: 100, height: 100)
                                } else {
                                    ProgressView()// Acts as a placeholder.
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear() {
            MenuList.getMenuData(viewContext: viewContext)
        }
    }
}

#Preview {
    MenuView()
}
