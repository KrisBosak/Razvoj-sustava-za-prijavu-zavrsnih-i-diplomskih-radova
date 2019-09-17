public class AddLineItemLightningController {

	@AuraEnabled
	public static void addLineItemOnInvoice(String recordId, String name1, String description, Decimal amount) {
		//System.debug('I am in backend controller');
		Invoice_Line_Item__c lineItem = new Invoice_Line_Item__c(
			Invoice__c = recordId,
			Description__c = description,
			Name = name1,
			Amount__c = amount
		);
		insert lineItem;
	}
}