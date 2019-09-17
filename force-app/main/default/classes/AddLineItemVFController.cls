public with sharing class AddLineItemVFController {
	public Invoice_Line_Item__c lineItem {get;set;}

	public AddLineItemVFController() {
		lineItem = new Invoice_Line_Item__c();
	}

	public void addLineItem() {
		Id recId = ApexPages.CurrentPage().getParameters().get('id');
		System.debug(recId);
		lineItem.Invoice__c = recId;
		insert lineItem;
		lineItem = new Invoice_Line_Item__c();
	}
}