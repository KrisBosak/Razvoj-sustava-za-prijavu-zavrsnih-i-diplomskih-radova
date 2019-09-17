trigger InvoiceTrigger on Invoice__c (before insert, before update) {
    List<VAT_data__mdt> vatDataList = [SELECT Country__c, VAT_rate__c FROM VAT_data__mdt];
    Map<String, VAT_data__mdt> vatDataMap = new Map<String, VAT_data__mdt>();
    for (VAT_data__mdt vatRecord : vatDataList) {
        vatDataMap.put(vatRecord.Country__c, vatRecord);
    }
    for (Invoice__c inv : Trigger.new) {
        System.debug(inv.Billing_Country__c);
        VAT_data__mdt vatToApply = vatDataMap.get(inv.Billing_Country__c);
        if (vatToApply != null) {
            inv.VAT__c = vatToApply.VAT_rate__c;
        }
    }
}