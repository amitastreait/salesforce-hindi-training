public class DateClassUtility {

    @InvocableMethod(label='Date Operations' 
                     description='Operations related to date class'
                     category='Date Utils'
                     iconName='slds:standard:date_time'
                    )
    // iconName - <slds:category:name> // see
    // iconName - <resource:namespace:resourceId> // managed packages
    public static List<Date> dateUtils(List<InputWrapper> inputs){
        // Date, Operation (addDays), NumberOfDays
        Date outputDate;
        if(inputs != null && inputs.size()>0){
            InputWrapper input = inputs.get(0);
            if(input.operationType == 'addDays'){
                outputDate = input.inputDate.addDays(input.numberOfDays);
            }else if(input.operationType == 'addMonths'){
                outputDate = input.inputDate.addMonths(input.numberOfMonths);
            }
        }
        return new List<Date>{outputDate};
    }
    
    public class InputWrapper{
        
        @InvocableVariable(label='Provide Date on which you want to perform operation'
                           required=true description='Provide Date on which you want to perform operation')
        public Date inputDate;
        
        @InvocableVariable(label='Provide the Operation that you want to perform' required=true
                           description='The valid operation types are addDays, addMonths, addYears')
        public String operationType;
        
        @InvocableVariable(label='Number of Months' required=false description='Number of Months for the operation')
        public Integer numberOfMonths;
        
        @InvocableVariable(label='Number of days' required=false description='Number of days for the operation')
        public Integer numberOfDays;
    }
}