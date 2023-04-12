public class OpportunityTriggerHandler {
    /*
    	Develop an Apex Trigger on Opportunity so that 
		if the Discount & Amount field is not blank then calculate the discount 
		and store it in the Discount Price field.

        To Calculate the discount use the below formula and store it in a variable
        Decimal discount = ( Discount * Amount ) / 100
        
        To Calculate the Discounted Price use the below calculation and store it in a variable 
        Decimal discountedAmount = Amount - discount;

	*/
    public static void handleBeforeInsert(List<Opportunity> opportunityList){
        for(Opportunity opp : opportunityList){
            if(opp.Amount != null && opp.Discount__c != null){
                Decimal discount = ( opp.Amount * opp.Discount__c ) / 100;
                Decimal discountedAmount = opp.Amount - discount;
                opp.Discounted_Price__c = discount;
                opp.Price_After_Discount__c  = discountedAmount;
            }
        }
    }
}