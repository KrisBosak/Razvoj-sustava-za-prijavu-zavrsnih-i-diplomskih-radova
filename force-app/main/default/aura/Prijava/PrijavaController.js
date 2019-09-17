({/*
	 doInit: function(cmp, handler) {
	 	var recId = cmp.get("v.recordId");
        var action = cmp.get("c.getZavrsni");
        action.setParams({
            "zrId" : recId
        });
        action.setCallback(this, function(result){
            if(result.getState() === "SUCCESS"){
                
                cmp.set("v.nazivZavrsnog", result.getReturnValue().Name);
	 			cmp.set("v.mentorZavrsnog", result.getReturnValue().Mentor__c);
            }
        });
        $A.enqueueAction(action);
	},*/
	
    handleLoad: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
    },

    handleSubmit: function(cmp, event, helper) {
        cmp.set('v.disabled', true);
        cmp.set('v.showSpinner', true);
    },

    handleError: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
    },

    handleSuccess: function(cmp, event, helper) {
        var params = event.getParams();
        cmp.set('v.recordId', params.response.id);
        cmp.set('v.showSpinner', false);
        cmp.set('v.saved', true);
    }
});