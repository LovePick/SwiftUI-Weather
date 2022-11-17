//
//  ForecastRouter.swift
//  Weather
//
//  Created by Supapon Pucknavin on 18/11/2565 BE.
//

import Foundation
import SwiftUI

extension ForecastView {
    func configureView() -> some View {
        var view = self
        let config = Configuration()
        let interactor = ForecastInteractor(config: config)
        let presenter = ForecastPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}

