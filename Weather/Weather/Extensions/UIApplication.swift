//
//  UIApplication.swift
//  Weather
//
//  Created by Supapon Pucknavin on 17/11/2565 BE.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
