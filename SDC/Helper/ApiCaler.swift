//
//  ApiCaler.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
import Alamofire
class NetworkService:UIViewController {
    
    
    func simpleRequest<T:Decodable>(url:String, method: HTTPMethod,params:Parameters? = .none, withLoading: Bool = false, completion:@escaping (DataResponse<T,AFError>) -> Void) {
        let headers = requestHeaders()
        
        DispatchQueue.main.async {
            if(withLoading == true) { UIViewController().showLoading() }
        }
        
        let escapedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        AF.request(escapedURL, method: method,parameters: params, encoding: APIConfig.encoding, headers: headers).responseDecodable { (response: (DataResponse<T,AFError>)) in
            
            DispatchQueue.main.async {
                if(withLoading == true) { UIViewController().hideLoading() }
            }
            
            print("🛠escapedURL",escapedURL)
            print("🛠escapedUR!!!!!!L",self.requestHeaders())
            
            print("🛠response.error",response.error)
            if(response.error != nil){completion(response)}
            
//            print("🛠Req\n",response.request?.cURL() ?? "","\n")
            //print("🛠Res\n",response.value,response.value)
            
            if let statusCode = response.response?.statusCode {
                
                if (statusCode >= 200  && statusCode <= 300) {
                    completion(response)
                }
                else if (statusCode >= 401  && statusCode <= 403) {
                    self.showErrorHud(msg: "NOT AUTHORIZED")
                } else {
                    self.showErrorHud(msg: response.error?.errorDescription ?? "")
                }
                
            }
            
        }
        
    }
    
    
    func requestHeaders() -> HTTPHeaders {
        var headers = HTTPHeaders()
        
        let token = Helper.shared.getToken() ?? ""
        
        let currentDeviceLanguageCode = Locale.current.languageCode ?? "en"
        headers.add(name: "Accept-Language", value: currentDeviceLanguageCode)
        if !(UserDefaults.standard.bool(forKey: "Guest")){
            
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        headers.add(name: "Accept-Language", value: currentDeviceLanguageCode)
        
        return headers
    }
    
    
    
}
