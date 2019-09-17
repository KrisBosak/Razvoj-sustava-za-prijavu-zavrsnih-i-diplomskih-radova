public class TestDataFactory {
	public static List<User> createProfesor(Integer kolicina){
        List<User> u = new List<User>();
        Profile p = [SELECT Id FROM Profile WHERE Name='Profesor']; 
        For(Integer i = 1; i <= kolicina; i++){
            u.add(new User(Alias = 'prof' + i, Email='profesoruser' + i + '@profesor.com', 
            EmailEncodingKey='UTF-8', LastName='Testing' + i, LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='profesorusers' + i + '@profesor.com'));   
        }
        
        return u;
    }
}