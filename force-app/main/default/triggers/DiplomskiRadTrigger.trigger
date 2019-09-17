trigger DiplomskiRadTrigger on Diplomski_Rad__c (after insert, after delete, before insert) {
    Set<Id> newUserserId = new Set<Id>();
    Set<Id> oldUserserId = new Set<Id>();
    List<User> userListZaUpdate = new List<User>();
    List<User> oldUserListZaUpdate = new List<User>();
    List<String> oldDiplomskiNameList = new List<String>();
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            for(Diplomski_Rad__c dr : [SELECT Id, Name FROM Diplomski_Rad__c]){
                String uMalaSlova = dr.Name.toLowerCase();
                oldDiplomskiNameList.add(uMalaSlova);              
            }
            
            for(Diplomski_Rad__c dr : Trigger.new){
                newUserserId.add(dr.Mentor__c);
                
                String provjeraMalihSlova = dr.Name.toLowerCase();
                if(oldDiplomskiNameList.contains(provjeraMalihSlova)){
                    dr.addError('Rad sa istim imenom vec postoji.');
                }
            }
        
            for(User u : [SELECT Broj_diplomskih_radova__c FROM User WHERE Id IN: newUserserId]){
                u.Broj_diplomskih_radova__c += 1;
                userListZaUpdate.add(u);
            }
            
            update userListZaUpdate;
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isDelete){
            for(Diplomski_Rad__c dr : Trigger.old){
                oldUserserId.add(dr.Mentor__c);
            }
            
            for(User u : [SELECT Broj_diplomskih_radova__c FROM User WHERE Id IN: oldUserserId]){
                u.Broj_diplomskih_radova__c -= 1;
                oldUserListZaUpdate.add(u);
            }
            
            update oldUserListZaUpdate;
        }
    }
}