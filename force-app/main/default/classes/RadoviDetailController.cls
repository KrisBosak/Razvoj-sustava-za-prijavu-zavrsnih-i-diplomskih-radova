public class RadoviDetailController {

	@auraEnabled public Zavrsni_Rad__c zr {get; set;}
    
    @auraEnabled
    public static Zavrsni_Rad__c getZavrsni(Id zrId){
        return [SELECT Name, Mentor__c
                 FROM Zavrsni_Rad__c 
                 WHERE Id = :zrId];
    }
}