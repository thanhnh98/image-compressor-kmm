//
//  HomeScreenViewModel.swift
//  iosApp
//
//  Created by Thanh on 15/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import shared

extension HomeScreen {
    class ViewModel: ObservableObject {
        @Published var text = "Loading..."
        init() {
            Greeting().greeting { greeting, error in
                DispatchQueue.main.async {
                    if let greeting = greeting {
                        self.text = greeting
                    } else {
                        self.text = error?.localizedDescription ?? "error"
                    }
                }
            }
        }
    }
}
