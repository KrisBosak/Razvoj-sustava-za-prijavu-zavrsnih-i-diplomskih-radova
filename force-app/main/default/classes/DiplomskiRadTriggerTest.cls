@isTest
public class DiplomskiRadTriggerTest {
	@testSetup
    static void setupData(){
        Integer i = 1;
        List<User> listaProfesora = TestDataFactory.createProfesor(i);
            
        insert listaProfesora;
    }
    
    @isTest
    static void diplomskiInsertAndDeleteTest(){
		User profesor = [SELECT Id FROM User WHERE Alias =: 'prof1' LIMIT 1];
        
        Test.startTest();
        
        System.runAs(profesor){
            for(Integer i = 1; i <= 10; i++){
                Diplomski_Rad__c diplomski = new Diplomski_Rad__c(
                    Name = 'diplomski' + i,
                    Mentor__c = profesor.Id
            	); 
                insert diplomski;
        	}
            
            Integer count = database.countQuery('SELECT count() FROM Diplomski_Rad__c');
            System.assertEquals(10, count);
            List<User> brojDiplomskih = [SELECT Id, Broj_diplomskih_radova__c FROM User WHERE Id =: profesor.Id LIMIT 1];
			System.assertEquals(10, brojDiplomskih[0].Broj_diplomskih_radova__c);  
            
            Diplomski_Rad__c diplomskiIstoIme = new Diplomski_Rad__c(
                    Name = 'diplomski1',
                    Mentor__c = profesor.Id
            ); 
            try{
                insert diplomskiIstoIme;
            }
            catch(Exception e){
                Boolean expectedExceptionThrown =  e.getMessage().contains('Rad sa istim imenom vec postoji') ? true : false;
                
            	System.assertEquals(expectedExceptionThrown, true);
                Integer count3 = database.countQuery('SELECT count() FROM Diplomski_Rad__c');
            	System.assertEquals(10, count3);
                List<User> brojDiplomskihIstoIme = [SELECT Id, Broj_diplomskih_radova__c FROM User WHERE Id =: profesor.Id LIMIT 1];
				System.assertEquals(10, brojDiplomskihIstoIme[0].Broj_diplomskih_radova__c); 
            }
            
            Diplomski_Rad__c maksimum = new Diplomski_Rad__c(
                Name = 'diplomski',
                Mentor__c = profesor.Id
            ); 
            
            try{
                insert maksimum;
            }
            catch(Exception e){
                Boolean expectedExceptionThrown =  e.getMessage().contains('Dosegnut maksimalan broj Vaših diplomskih radova!') ? true : false;
                
            	System.assertEquals(expectedExceptionThrown, true);
                Integer count4 = database.countQuery('SELECT count() FROM Diplomski_Rad__c');
            	System.assertEquals(10, count4);
                List<User> brojDiplomskihMaksimum = [SELECT Id, Broj_diplomskih_radova__c FROM User WHERE Id =: profesor.Id LIMIT 1];
				System.assertEquals(10, brojDiplomskihMaksimum[0].Broj_diplomskih_radova__c); 
            }
            
            Diplomski_Rad__c diplomskiBrisanje = [SELECT Id, Name FROM Diplomski_Rad__c WHERE Name =: 'diplomski1' LIMIT 1];
            system.debug('brisanje: ' + diplomskiBrisanje);
            delete diplomskiBrisanje;
            
            Integer count5 = database.countQuery('SELECT count() FROM Diplomski_Rad__c');
            System.assertEquals(9, count5);
        }
        
        Test.stopTest();
    }
}