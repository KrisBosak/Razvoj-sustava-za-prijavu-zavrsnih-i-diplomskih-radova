@isTest
public class ZavrsniRadTriggerTest {
	@testSetup
    static void setupData(){
        Integer i = 1;
        List<User> listaProfesora = TestDataFactory.createProfesor(i);
            
        insert listaProfesora;
    }
    
    @isTest
    static void zavrsniInsertAndDeleteTest(){
		User profesor = [SELECT Id FROM User WHERE Alias =: 'prof1' LIMIT 1];
        
        Test.startTest();
        
        System.runAs(profesor){
            for(Integer i = 1; i <= 10; i++){
                Zavrsni_Rad__c zavrsni = new Zavrsni_Rad__c(
                    Name = 'zavrsni' + i,
                    Mentor__c = profesor.Id
            	); 
                insert zavrsni;
        	}
            
            Integer count = database.countQuery('SELECT count() FROM Zavrsni_Rad__c');
            System.assertEquals(10, count);
            List<User> brojZavrsnih = [SELECT Id, Broj_zavrsni_radova__c FROM User WHERE Id =: profesor.Id LIMIT 1];
			System.assertEquals(10, brojZavrsnih[0].Broj_zavrsni_radova__c);  
            
            Zavrsni_Rad__c zavrsniIstoIme = new Zavrsni_Rad__c(
                    Name = 'zavrsni1',
                    Mentor__c = profesor.Id
            ); 
            try{
                insert zavrsniIstoIme;
            }
            catch(Exception e){
                Boolean expectedExceptionThrown =  e.getMessage().contains('Rad sa istim imenom vec postoji') ? true : false;
                
            	System.assertEquals(expectedExceptionThrown, true);
                Integer count3 = database.countQuery('SELECT count() FROM Zavrsni_Rad__c');
            	System.assertEquals(10, count3);
                List<User> brojZavrsnihIstoIme = [SELECT Id, Broj_zavrsni_radova__c FROM User WHERE Id =: profesor.Id LIMIT 1];
				System.assertEquals(10, brojZavrsnihIstoIme[0].Broj_zavrsni_radova__c); 
            }
            
            Zavrsni_Rad__c maksimum = new Zavrsni_Rad__c(
                Name = 'zavrsni',
                Mentor__c = profesor.Id
            ); 
            
            try{
                insert maksimum;
            }
            catch(Exception e){
                Boolean expectedExceptionThrown =  e.getMessage().contains('Maksimalan broj ponuđenih radova dostignut.') ? true : false;
                
            	System.assertEquals(expectedExceptionThrown, true);
                Integer count4 = database.countQuery('SELECT count() FROM Zavrsni_Rad__c');
            	System.assertEquals(10, count4);
                List<User> brojZavrsnihMaksimum = [SELECT Id, Broj_zavrsni_radova__c FROM User WHERE Id =: profesor.Id LIMIT 1];
				System.assertEquals(10, brojZavrsnihMaksimum[0].Broj_zavrsni_radova__c); 
            }
            
            Zavrsni_Rad__c zavrsniBrisanje = [SELECT Id, Name FROM Zavrsni_Rad__c WHERE Name =: 'zavrsni1' LIMIT 1];
            system.debug('brisanje: ' + zavrsniBrisanje);
            delete zavrsniBrisanje;
            
            Integer count5 = database.countQuery('SELECT count() FROM Zavrsni_Rad__c');
            System.assertEquals(9, count5);
        }
        
        Test.stopTest();
    }
}