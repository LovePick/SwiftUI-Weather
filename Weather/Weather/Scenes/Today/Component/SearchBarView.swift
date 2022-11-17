//
//  SearchBarView.swift
//  Weather
//
//  Created by Supapon Pucknavin on 17/11/2565 BE.
//

import SwiftUI

struct SearchBarView: View {
    // MARK: - PROPERTY
    @Binding var searchText: String
    @Binding var placeholder: String
    
    
    // MARK: - BODY
    var body: some View {
        
        HStack {
            Image(systemName: "location.magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $searchText)
                .foregroundColor(.gray)
                
            
            if !searchText.isEmpty {
                Button(
                    action: {
        
                        UIApplication.shared.endEditing()
                        self.searchText = ""
                    },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.gray)
                    }
                )
            }
            
        }//: HSTACK
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), placeholder: .constant("city name"))
            .previewLayout(.sizeThatFits)
    }
}
