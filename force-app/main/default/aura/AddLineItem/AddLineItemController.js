({
	addLineItem : function(component, event, helper) {
		console.log("I will add line item now");
		var action = component.get("c.addLineItemOnInvoice");
		action.setParams({ recordId : component.get("v.recordId"),
							name1: component.find("name").get("v.value"), 
							description: component.find("description").get("v.value"),
							amount: component.find("amount").get("v.value")});

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
				console.log("success");
                //alert("From server: " + response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
	}
})