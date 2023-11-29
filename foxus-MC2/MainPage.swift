//
//  MainPage.swift
//  foxus-MC2
//
//  Created by AlJawharh AlOtaibi on 14/05/1445 AH.
//

import SwiftUI

struct MainPage: View {
    @State var HistoryView: Bool = false

    let subtitle: String = "Whack the unexpected, seize the Day"
    var body: some View {
        NavigationStack{
            VStack{
                Text(subtitle)
                    .position(x:147,y:7)
                    .font(.subheadline)
            }
            
            Button (action: {
                HistoryView.toggle()
            }) {
                Image("LOGO 1")
                    .resizable()
                    .frame(width: 34 , height: 34)
                    .padding()
                    .foregroundColor(.blue)
            }
            .position(x:350 , y: -350)
            Spacer()
        
                .navigationTitle("Good Morning,")
            }
        .fullScreenCover(isPresented: $HistoryView) {
                    CalenderView()
                .padding()
                    }
        
       
    }
}

import Foundation
