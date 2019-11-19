//
//  Login_helper.swift
//  Rove Teacher Portal
//
//  Created by Hassan Abbasi on 24/05/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import FirebaseAuth


class Login_helper{
   
    var authDelegate:AuthUIDelegate?

  
    func sendVerificationCode(number:String, completion: @escaping (Result<String,Error>) -> Void){
        
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: authDelegate) { (verificationID, error) in
            if let unwrappedError = error{
               completion(.failure(unwrappedError))
               return
            }
            if let vID =  verificationID {
            completion(.success(vID))
            }
        }
        
    }
    
    
    
    
}


