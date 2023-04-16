import Alamofire
class APIConfig {

    
    static let BaseURL = "https://sdce.br-ws.com/api/"
    
    
    static let Login = BaseURL  + "authentication/login"
    
    static let GetInvOwnership = BaseURL  + "investor_information/getInvOwnership"
    static let GetInvestorInfo = BaseURL  + "investor_information/getInvestorInfo"

    static let GetAccountInfo = BaseURL  + "investor_information/getAccountsList"

    
    
    static let GetLastTrans = BaseURL  + "investor_information/getLastTrans"
    static let OwnershipAnalysis = BaseURL  + "investor_information/ownershipAnalysis"
    static let TradesAnalysis = BaseURL  + "investor_information/tradesAnalysis"

    
    
    
    static let ChangePassword = BaseURL  + "authentication/changePassword"

    static let GetSysDates = BaseURL + "investor_information/getSysDates"
//    static let baseURL = "http://preinsouq1-001-site1.btempurl.com/api" //


    
    
    static let encoding = JSONEncoding.default
    static let stringencoding = JSONEncoding.default
    static let encoding2 = URLEncoding.queryString
    
}
