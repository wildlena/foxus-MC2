//  MainPage.swift
//  foxus-MC2
//
//  Created by AlJawharh AlOtaibi on 09/05/1445 AH.
//
import SwiftUI
import UIKit

struct Task: Identifiable {
    var id = UUID()
    var name: String
    var time: Date // Change 'time' type to Date
    var priority: Priority
}
enum Priority: String, CaseIterable {
    case low = "Low"
    case med = "   Medium"
    case high = "High"
    case extreme = "     Extreme"
    
    var color: Color {
        switch self {
        case .low:
            return Color.yellow
        case .med:
            return Color.orange
        case .high:
            return Color.red
        case .extreme:
            return Color(red: 0.6, green: 0.0, blue: 0.0)
        }
    }
}
struct ContentView: View {
    @State private var isShowingSheet = false
    @State private var taskName = ""
    @State private var taskTime = Date() // Change to Date type
    @State private var selectedPriority: Priority? = nil
    @State private var tasks: [Task] = []
    @State private var historyView: Bool = false
    @State var selection: Int = 0
    @State var searchTerm = ""
    @State var isSearching = false
    let subtitle: String = "Whack the unexpected, seize the day"

    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    VStack(alignment: .leading){
                        HStack{Spacer()}
                        
                        
                        Text(subtitle)
                            .font(.subheadline).padding(.leading)
                        
                        
                        Picker("Choose a side",selection: $selection ) {
                            Text("Upcoming").tag(0)
                            Text("Completed").tag(1)
                        }.padding(0).padding()
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.top, 10)
                        
                        if(selection == 0){
                            List(tasks) { task in
                                TaskCardView(task: task)
                            }
                        }
                
                        Spacer()
                        
                    }
                    Spacer()
                    
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        Text("New Task")
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.customColor)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    }
                    .padding()
                }
                
              //  Color("Primarycolor").edgesIgnoringSafeArea(.all)
                
                .navigationTitle("Good Morning,")
                .navigationBarBackButtonHidden(true)
                //            .navigationBarTitleDisplayMode(.automatic)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        NavigationLink(destination: CalenderView()) {
                            VStack {
                                
                                Image("LOGO 1")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            TaskInputSheet(isPresented: $isShowingSheet, taskName: $taskName, taskTime: $taskTime, selectedPriority: $selectedPriority, tasks: $tasks)
        }
    }
}
struct TaskInputSheet: View {
    @Binding var isPresented: Bool
    @Binding var taskName: String
    @Binding var taskTime: Date // Change to Date type
    @Binding var selectedPriority: Priority?
    @Binding var tasks: [Task]
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $taskName)
                    DatePicker("Time", selection: $taskTime, displayedComponents: .hourAndMinute) // Change to DatePicker for time
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(Priority.allCases.chunked(into: 2), id: \.self) { prioritiesRow in
                            HStack(spacing: 20) {
                                ForEach(prioritiesRow, id: \.self) { priority in
                                    Button(action: {
                                        selectedPriority = priority
                                    }) {
                                        HStack {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(selectedPriority == priority ? priority.color : Color.gray.opacity(0.3), lineWidth: 2)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .fill(selectedPriority == priority ? priority.color : Color.white)
                                                    )
                                                    .frame(width: 100, height: 50)
                                                    .overlay(
                                                        Circle()
                                                            .fill(priority.color)
                                                            .frame(width: 20, height: 20)
                                                            .offset(x: -35)
                                                    )
                                                    .overlay(
                                                        Text(priority.rawValue)
                                                            .foregroundColor(selectedPriority == priority ? .white : .black)
                                                    )
                                            }
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                Section {
                    Button(action: {
                        if areFieldsValid() {
                            guard let priority = selectedPriority else { return }
                            let newTask = Task(name: taskName, time: taskTime, priority: priority) // Update Task initialization
                            tasks.append(newTask)
                            print("New Task: \(newTask)")
                            isPresented = false
                        } else {
                            showErrorAlert = true
                        }
                    }) {
                        Text("Save Task")
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.customColor)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    }
                }
            }
            .navigationBarTitle("New Task")
            .navigationBarItems(trailing: Button("Close") {
                isPresented = false
            })
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    private func areFieldsValid() -> Bool {
        if taskName.isEmpty || selectedPriority == nil {
            errorMessage = "Please fill in all the mandatory fields."
            return false
        }
        return true
    }
}
struct TaskCardView: View {
    var task: Task
    @State private var isChecked: Bool = false
    var body: some View {
        HStack{
        VStack(alignment: .leading) {
            Text("Name: \(task.name)")
            Text("Time: \(formattedTime(task.time))") // Display formatted time
            Text("Priority: \(task.priority.rawValue)")}
                .padding()
                           .background(Color.gray.opacity(0.1))
                           .cornerRadius(15)
                           .padding([.horizontal, .bottom])
                       
            
            Button(action: {
                isChecked.toggle()
            }) {
                Text("DONE!")
            }
            .buttonStyle(CheckboxStyle(isChecked: $isChecked))
            
        }
        .swipeActions {
                Button(role:.destructive) {
                    print("Delete")
                }label:{
                    Label("Delete", systemImage: "trash.circle.fill")
                }
            Button {
                print("Edit")
            }label:{
                Label("Edit", systemImage: "pencil")
                }
            .tint(.green)
              }
            }
    
    private func formattedTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
}
struct CheckboxStyle: ButtonStyle {
    @Binding var isChecked: Bool

    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(isChecked ? .blue : .secondary)
            configuration.label
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

