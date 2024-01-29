import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var path: NavigationPath
    @State private var searchText = ""
    @State private var categoryFiltered = ""
    
    let categories: [String] = ["Starters", "Mains", "Desserts", "Drinks"]
    
    var body: some View {
        ScrollView {
            LLHero()
                .withSearchTextField(searchText: $searchText)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("ORDER FOR DELIVERY!")
                    .font(.headline)
                    .padding([.top, .leading, .trailing])
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(categories) { category in
                            if categoryFiltered != category {
                                Button(category) {
                                    categoryFiltered = category
                                }
                                .buttonStyle(LLLightButton())
                            }
                            if categoryFiltered == category {
                                Button(category) {
                                    categoryFiltered = ""
                                }
                                .buttonStyle(LLGreenButton())
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            FetchedObjects(predicate: predicateByTitle(), sortDescriptors: sortDishByTitle()) { (dishes: [Dish]) in
                VStack {
                    ForEach(dishes, id: \.self) { dish in
                        HStack{
                            VStack(alignment: .leading) {
                                Text("\(dish.title!)")
                                    .font(.headline)
                                    .padding(.bottom, 6)
                                Text("\(dish.descriptions!)")
                                    .lineLimit(2)
                                    .foregroundColor(.littleLemonGreen)
                                    .padding(.bottom, 6)
                                Text("$\(dish.price, specifier: "%.2f")")
                                    .foregroundColor(.littleLemonGreen)
                                    .padding(.bottom, 6)
                                    .bold()
                            }
                            Spacer()
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 75, height: 75)
                        }
                        Divider()
                    }
                }
                .padding(.all)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(.littleLemonBanner)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 4)
            }
            ToolbarItem(placement: .confirmationAction) {
                NavigationLink(value: "UserProfile", label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .tint(Color(.littleLemonGreen))
                })
            }
        }
        .onAppear(perform: {
            getMenuData()
        })
        .padding(.bottom, 22)
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension Menu {
    
    func sortDishByTitle() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
    }
    
    func predicateByTitle() -> NSPredicate {
        if searchText.isEmpty && categoryFiltered.isEmpty {
            return NSPredicate(value: true)
        }
        
        var predicates: [NSPredicate] = []
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        if !categoryFiltered.isEmpty {
            predicates.append(NSPredicate(format: "category CONTAINS[cd] %@", categoryFiltered))
        }
        
        
        return NSCompoundPredicate(type: .and
                                   , subpredicates: predicates)
    }
    
    func getMenuData() {        
        PersistenceController.shared.clear()
        
        let MENU_URL = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        let url = URL(string: MENU_URL)!
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                print("DATA \(data)")
                let fullMenu = try? JSONDecoder().decode(JSONMenu.self, from: data)
                if let menu = fullMenu?.menu {
                    menu.forEach { item in
                        let dish = Dish(context: viewContext)
                        dish.title = item.title
                        dish.descriptions = item.description
                        dish.image = item.image
                        if let price = Float(item.price) {
                            dish.price = price
                        }
                        dish.category = item.category
                    }
                    
                    try? viewContext.save()
                }
            }
            
        }
        task.resume()
    }
}

struct Menu_Previews: PreviewProvider {
    @State static var path: NavigationPath = .init()
    
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        NavigationStack {
            Menu(path: $path).environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
