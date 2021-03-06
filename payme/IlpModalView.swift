//
//  IlpModalView.swift
//  payme
//
//  Created by Noah Kramer on 3/14/20.
//  Copyright © 2020 sunyata tools. All rights reserved.
//

import SwiftUI
import XpringKit

struct IlpModalView: View {
    @Binding var showModal: Bool
    @Binding var accountID: String
    @Binding var targetID: String
    @Binding var paymentResult: PaymentResult
    @Binding var assetScale: UInt32
    
    var body: some View {
        VStack {
            Image("interledger")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            if (paymentResult.successfulPayment) {
                Text("Payment complete!")
                    .font(.largeTitle)
                    .padding()
            } else {
                Text("Oops... We were unable to send the full amount")
                    .font(.largeTitle)
                    .padding()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("From: \(self.accountID)")
                Text("To: \(self.targetID)")
                Text("Original Amount: \(MoneyUtils.toUserFriendly(realAmount: self.paymentResult.originalAmount, assetScale: self.assetScale))")
                Text("Amount Delivered: \(MoneyUtils.toUserFriendly(realAmount: self.paymentResult.amountDelivered, assetScale: self.assetScale))")
                Text("Amount Sent: \(MoneyUtils.toUserFriendly(realAmount: self.paymentResult.amountSent, assetScale: self.assetScale))")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            
            Button(action: {
                self.showModal.toggle()
            }) {
                Text("Dismiss")
            }
            .buttonStyle(NavButtonStyle(backgroundColor: .green))
        }
    }
}

struct IlpModalView_Previews: PreviewProvider {
    static var previews: some View {
        IlpModalView(
            showModal: .constant(true),
            accountID: .constant(""),
            targetID: .constant(""),
            paymentResult: .constant(PaymentResult(sendPaymentResponse: Org_Interledger_Stream_Proto_SendPaymentResponse())),
            assetScale: .constant(9)
        )
    }
}
