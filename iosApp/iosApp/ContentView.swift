import SwiftUI
import shared

struct ContentView: View {
    let appDataBase : AppDataBase = AppDataBase(driverFactory: DriverFactory())
    
    @State var itemList : [TODOItem] = []
    @State var fieldText = ""
    
    var body: some View {
        VStack{
            HStack {
                TextField("enter TODO Title", text: $fieldText)
                Spacer()
                Button("ADD") {
                    appDataBase.insertItem(title: fieldText) { error in
                        updateItem(error: error) {
                            fieldText = ""
                        }
                    }
                }
            }.padding(10)
            ForEach(itemList,id:\.self) { item in
                ToDoRow(item: item) {
                    appDataBase.deleteItem(id: item.id) { error in
                        updateItem(error: error)
                    }
                } updateToggle: {
                    appDataBase.updateCheck(checked: !item.isFinish, id: item.id) { error in
                        updateItem(error: error)
                    }
                }
                
            }
            Spacer()
        }.onAppear {
            updateItem(error:nil)
        }
    }
    
    func updateItem(error: Error?,otherAction :@escaping ()->Void = {}) {
        if let error = error {
            print(error)
        } else {
            appDataBase.getAllItems { list, error in
                if let itemList = list {
                    self.itemList = itemList
                    otherAction()
                }
            }
        }
    }
}

struct ToDoRow: View {
    let item : TODOItem
    let actionDelete : () -> Void
    let updateToggle : () -> Void
    var body: some View {
        HStack{
            Text(item.title)
            Spacer()
            Image(systemName: item.isFinish ? "checkmark.square.fill" : "square")
                .foregroundColor(item.isFinish ? Color(UIColor.systemBlue) : Color.secondary)
                .onTapGesture {
                    updateToggle()
                }
            Button("Delete") {
                actionDelete()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
