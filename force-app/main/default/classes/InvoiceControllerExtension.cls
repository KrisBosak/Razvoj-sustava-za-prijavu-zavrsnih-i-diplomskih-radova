public with sharing class InvoiceControllerExtension {
	private final Invoice__c invoice;
	public List<Invoice_Line_Item__c> lineItemList {get; set;}
	public InvoiceControllerExtension(ApexPages.StandardController stdController) {
		this.invoice = (Invoice__c)stdController.getRecord();
		this.lineItemList = [SELECT Id, Amount__c, Name, Description__c FROM Invoice_Line_Item__c WHERE Invoice__c =: this.invoice.id];
	}
}