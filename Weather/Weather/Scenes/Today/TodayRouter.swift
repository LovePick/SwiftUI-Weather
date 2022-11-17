//
//  TodayRouter.swift
//  Weather
//
//  Created by Supapon Pucknavin on 16/11/2565 BE.
//

import SwiftUI

extension TodayView {
    func configureView() -> some View {
        var view = self
        let config = Configuration()
        let interactor = TodayInteractor(config: config)
        let presenter = TodayPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}
