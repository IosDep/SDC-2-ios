import Foundation


final class Helper {
    static let shared = Helper()
    
    
    
    func saveAppLang(lang:String)
    {
        let def = UserDefaults.standard
        def.setValue(lang, forKey: "Lang")
        def.synchronize()
    }
    
    func SaveUserToken(token:String)
    {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "token")
        def.synchronize()
    }
    
    
    func SaveSeassionId(seassionId:String)
    {
        let def = UserDefaults.standard
        def.setValue(seassionId, forKey: "seassion")
        def.synchronize()
    }
    
    
    func saveUserId(id:Int)
    {
        let def = UserDefaults.standard
        def.setValue(id, forKey: "UserId")
        def.synchronize()
    }
    
    func getIsLogin()-> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "isLogin" ) as? Bool
    }
  
    func getUserToken()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "token" ) as? String
    }
    
    
    func getUserSeassion()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "seassion" ) as? String
    }
    
    func getUserId()-> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "UserId" ) as? Int
    }
    func saveToken(auth:String)
    {
        let def = UserDefaults.standard
        def.setValue(auth, forKey: "user_token")
        def.synchronize()
    }
    func getToken()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "user_token" ) as? String
    }
    func saveUserPhoneNumber(phone:String)
    {
        let def = UserDefaults.standard
        def.setValue(phone, forKey: "UserPhoneNumber")
        def.synchronize()
    }
    func getUserPhoneNumber()-> String?{
        let def = UserDefaults.standard
        let phone = def.object(forKey: "UserPhoneNumber") as? String
        print("PHONE__",phone)
        return phone
    }
    func saveUserEmail(name:String)
    {
        let def = UserDefaults.standard
        def.setValue(name, forKey: "user_email")
        def.synchronize()
    }
    func getUserEmail()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "user_email") as? String
    }
    
    
    
    
    func saveUserAddress(address:String)
    {
        let def = UserDefaults.standard
        def.setValue(address, forKey: "user_address")
        def.synchronize()
    }
    func getUserAddress()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "user_address") as? String
    }
    func saveUserCity(city:String)
    {
        let def = UserDefaults.standard
        def.setValue(city, forKey: "user_city")
        def.synchronize()
    }
    func getUserCity()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "user_city") as? String
    }
    

    
    
    
}

