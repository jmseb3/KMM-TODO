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
                    appDataBase.insertItem(title: fieldText)
                }
            }.padding(10)
            ForEach(itemList,id:\.self) { item in
                ToDoRow(item: item) {
                    appDataBase.deleteItem(id: item.id)
                } updateToggle: {
                    appDataBase.updateCheck(checked: !item.isFinish, id: item.id)
                }
            }
            Spacer()
        }.onAppear {
            appDataBase.getAllItemFlow().collect(collector: Collector<[TODOItem]> {value in
                self.itemList = value
            }) { error in
                print(error ?? "")
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
