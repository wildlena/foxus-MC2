//
//  CalenderView.swift
//  foxus-MC2
//
//  Created by leena alyami on 13/05/1445 AH.
//

import SwiftUI

struct CalenderView: View {
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        
       ZStack{
            Color(.white).ignoresSafeArea(.all)
                .navigationBarHidden(true)
            
            
          
            VStack(alignment: .leading){
               HStack{Spacer()}
                
                Button("Back"){
                    presentationMode.wrappedValue.dismiss()
                    
                }.padding(.leading)
                Spacer()
          }
        
               
        }
            
        
        
    }
}

#Preview {
    CalenderView()
}
