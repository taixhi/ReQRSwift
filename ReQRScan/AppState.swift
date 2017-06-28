//
//  AppState.swift
//  ReQRScan
//
//  Created by 加藤 太一 on 2017/06/27.
//  Copyright © 2017 Team Lab Inc. All rights reserved.
//

import ReSwift
//States
public struct AppState: StateType{
    var qrDisplayString: String = "hello!"
    var qrInfo: QRInfo? = nil
    var scannedString: String? = nil
}
//Actions
struct CreateQRDisplayString: Action {
    var qrString: String
}
struct StringScanned: Action {
    var string: String
}
//Reducers
func qrDisplayReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    switch action {
    case let action as CreateQRDisplayString:
        state.qrDisplayString = action.qrString
    case let action as StringScanned:
        state.scannedString = action.string
    default:
        break
    }
    return state
}
//Store
let mainStore = Store<AppState>(
    reducer: qrDisplayReducer,
    state: nil
)

