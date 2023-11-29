//
//  MainPageReview.swift
//  foxus-MC2
//
//  Created by leena alyami on 13/05/1445 AH.
//

import SwiftUI

struct MainPageReview: View {
    @State private var historyView: Bool = false
    @State var selection: Int = 0
    @State var searchTerm = ""
    @State var isSearching = false
    let subtitle: String = "Whack the unexpected, seize the day"
    
    var body: some View {
        
        NavigationView {
            ZStack{
                
                
              //  Color("Primarycolor").edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    
                    
                    Text(subtitle)
                        .font(.subheadline).padding(.leading)
                    
                    
                    Picker("Choose a side",selection: $selection) {
                        Text("Upcoming").tag(0)
                        Text("Completed").tag(1)
                    }.padding(0).padding()
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.top, 10)
                    
                    Spacer()
                    
                }
                
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
            
          
//                .onAppear{
//                    
//                } //good morning
            
            }
            
        }
    }




struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPageReview()
    }
}

