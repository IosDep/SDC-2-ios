import Alamofire
class APIConfig {

    
    static let BaseURL = "https://sdce5.blueraydev.com/api/"
    static let Phase2Url = "http://194.165.152.9/"
    
    static let Login = BaseURL  + "authentication/login"
    static let changePassword = BaseURL  + "investor_information/changePassword"
    static let getRecoveryData = BaseURL  + "investor_information/getRecoveryInfo"
    static let validateOTP = BaseURL  + "sdc/otp-validate"
    
    static let getRequestOTP = BaseURL  + "sdc/otp-request"
    
    static let GetInvOwnership = BaseURL  + "investor_information/getInvOwnership"
    
    
    
    static let GetInvOwnershipPDF = BaseURL  + "investor_information/getInvOwnershipPdf"
    
    static let GetInvestorInfo = BaseURL  + "investor_information/getInvestorInfo"
    
    static let GetInvestorInfoPDF = BaseURL  + "investor_information/getInvestorInfoPdf"
    

    static let GetAccountInfo = BaseURL  + "investor_information/getAccountsList"
    
    static let GetAccountInfoPDF = BaseURL  + "investor_information/getAccountsListPdf"
    

    static let GetNotfication = BaseURL  + "investor_information/getNotifications"
    
    static let GetLoginToken = Phase2Url  + "sdc-api-eservice/api/auth/login"
    
    
    
    static let GetAccountOwnerShpe = BaseURL  + "investor_information/getAccountOwnership"
    
    static let GetAccountOwnerShpePDF = BaseURL  + "investor_information/getAccountOwnershipPdf"


    static let GetLastAction = BaseURL  + "investor_information/lastcorporateactions"
        
    static let GetLastTrans = BaseURL  + "investor_information/getLastTrans"
    static let OwnershipAnalysis = BaseURL  + "investor_information/ownershipAnalysis"
    static let TradesAnalysis = BaseURL  + "investor_information/tradesAnalysis"
    
    static let GetSecurityPwnership = BaseURL + "investor_information/getInvOwnership"
    
    static let GetNationality = BaseURL  + "investor_information/getOtherNat"
    
    static let GetSecurityOwnership = BaseURL + "investor_information/getSecurityOwnershipWithGetAccountsList"
    
    static let GetSecurityOwnershipPDF = BaseURL + "investor_information/getSecurityOwnershipWithGetAccountsListPdf"

    static let GetSysDates = BaseURL + "investor_information/getSysDates"
//    static let baseURL = "http://preinsouq1-001-site1.btempurl.com/api" //


    static let getMemberId = BaseURL + "investor_information/getAccountInfoByMemberID"
    
    static let GetAccountInvInfo = BaseURL + "investor_information/getAccountInfo"
    
    static let GetAccountInvInfoPDF = BaseURL + "investor_information/getAccountInfoPdf"
    
    
    static let GetAccountStatementPDF = BaseURL + "investor_information/getSecurityDetailedTrans"
    
    
    static let CreatePassword = BaseURL + "investor_information/createPassword"
    
    
    static let GetSliderImages = BaseURL + "investor_information/getSliders"
    
    static let GetMobileLayouts = BaseURL + "investor_information/getMobileLayouts"
    
    static let RegesterInfo =  BaseURL + "authentication/register"
    
    static let GetLInks =  BaseURL + "investor_information/getAccountSettings"

    
    static let createUssr =  Phase2Url + "sdc-api-eservice/api/ninRequestWithSMS"
    
    static let GetClintInf = BaseURL + "authentication/clientInfo"
    
    static let encoding = JSONEncoding.default
    static let stringencoding = JSONEncoding.default
    static let encoding2 = URLEncoding.queryString
    
    
    
}
