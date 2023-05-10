import Alamofire
class APIConfig {

    
    static let BaseURL = "https://sdce5.blueraydev.com/api/"
    
    static let Login = BaseURL  + "authentication/login"
    
    static let GetInvOwnership = BaseURL  + "investor_information/getInvOwnership"
    static let GetInvestorInfo = BaseURL  + "investor_information/getInvestorInfo"

    static let GetAccountInfo = BaseURL  + "investor_information/getAccountsList"

    static let GetNotfication = BaseURL  + "investor_information/getNotifications"
    
    static let GetAccountOwnerShpe = BaseURL  + "investor_information/getAccountOwnership"

    static let GetLastAction = BaseURL  + "investor_information/lastcorporateactions"
    
    static let GetLastTrans = BaseURL  + "investor_information/getLastTrans"
    static let OwnershipAnalysis = BaseURL  + "investor_information/ownershipAnalysis"
    static let TradesAnalysis = BaseURL  + "investor_information/tradesAnalysis"
    
    static let GetSecurityPwnership = BaseURL + "investor_information/getInvOwnership"
    
    static let GetNationality = BaseURL  + "investor_information/getOtherNat"
    
    static let ChangePassword = BaseURL  + "authentication/changePassword"
    static let GetSecurityOwnership = BaseURL  + "investor_information/getSecurityOwnership"

    static let GetSysDates = BaseURL + "investor_information/getSysDates"
//    static let baseURL = "http://preinsouq1-001-site1.btempurl.com/api" //


    static let GetAccountInvInfo = BaseURL + "investor_information/getAccountInfo"
    
    static let encoding = JSONEncoding.default
    static let stringencoding = JSONEncoding.default
    static let encoding2 = URLEncoding.queryString
    
}
