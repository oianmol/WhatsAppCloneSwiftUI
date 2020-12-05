//
//  SearchBar.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI


struct SearchBar : UIViewRepresentable {
    @Binding var text : String
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        text = searchText
    }
    
    func makeCoordinator() -> Cordinator {
        return Cordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}


class Cordinator : NSObject, UISearchBarDelegate {
    @Binding var text : String
    init(text : Binding<String>)
    {
        _text = text
    }
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String)
    {
        text = searchText
    }
}

