trigger ZavrsniRadTrigger on Zavrsni_Rad__c (after insert, after delete, before insert) {
    Set<Id> newUsersId = new Set<Id>();
    Set<Id> oldUsersId = new Set<Id>();
    List<User> userListZaUpdate = new List<User>();
    List<User> oldUserListZaUpdate = new List<User>();
    List<String> oldZavrsniNameList = new List<String>();
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            for(Zavrsni_Rad__c zr : [SELECT Id, Name FROM Zavrsni_Rad__c]){
                String uMalaSlova = zr.Name.toLowerCase();
                oldZavrsniNameList.add(uMalaSlova);                
            }
            
            for(Zavrsni_Rad__c zr : Trigger.new){
                newUsersId.add(zr.Mentor__c);
                
                String provjeraMalihSlova = zr.Name.toLowerCase();
                if(oldZavrsniNameList.contains(provjeraMalihSlova)){
                    zr.addError('Rad sa istim imenom vec postoji.');
                }
            }
        
            for(User u : [SELECT Broj_zavrsni_radova__c, Name FROM User WHERE Id IN: newUsersId]){
                u.Broj_zavrsni_radova__c += 1;
                userListZaUpdate.add(u);
            }
            
            update userListZaUpdate;
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isDelete){
            for(Zavrsni_Rad__c zr : Trigger.old){
                oldUsersId.add(zr.Mentor__c);
            }
    
            for(User u : [SELECT Broj_zavrsni_radova__c FROM User WHERE Id IN: oldUsersId]){
                 u.Broj_zavrsni_radova__c -= 1;
                 oldUserListZaUpdate.add(u);
            }
            
            update oldUserListZaUpdate;
        }
    }
}