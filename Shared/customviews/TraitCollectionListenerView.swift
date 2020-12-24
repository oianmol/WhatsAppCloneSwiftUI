//
//  TraitCollectionListenerView.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 24/12/20.
//

import Foundation
import SwiftUI
import UIKit

struct TraitCollectionListenerView: UIViewControllerRepresentable {
    var traitCollectionDidChange: (_ previous: UITraitCollection?, _ current: UITraitCollection?) -> Void = { _,_  in }
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<TraitCollectionListenerView>) -> TraitCollectionViewController {
        TraitCollectionViewController()
    }
    func updateUIViewController(_ uiViewController: TraitCollectionViewController,
                                context: UIViewControllerRepresentableContext<TraitCollectionListenerView>) {
        uiViewController._traitCollectionDidChange = traitCollectionDidChange
        if let nc = uiViewController.navigationController {
                  self.configure(nc)
              }
    }
    class TraitCollectionViewController: UIViewController {
        var _traitCollectionDidChange: (_ previous: UITraitCollection?, _ current: UITraitCollection?) -> Void = { _,_  in }
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            _traitCollectionDidChange(previousTraitCollection, traitCollection)
        }
        
    }
}
