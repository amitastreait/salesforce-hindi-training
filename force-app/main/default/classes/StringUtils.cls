public class StringUtils {
	@InvocableMethod(label='Convert String to Array & Vice Versa' 
                     description='Convert String to Array & Vice Versa'
                     category='PantherSchools'
                     iconName='slds:custom:custom57'
                    )
    public static void stringUtils(List<InputWrapper> inputs){ //List<Object>
        if(inputs != null && inputs.size()>0){
            InputWrapper input = inputs.get(0);
            String colors = 'Red,Blue,Yellow';
            List<String> colorsList = colors.split(',');
            // join
            String joinedString = String.join(colorsList, ':');
        }
    }
    
    public class InputWrapper{
        
        @InvocableVariable(label='Provide the String to Convert into Array'
                           description='Provide the String to Convert into Array')
        public String inputString;
        
        @InvocableVariable(label='Provide the List to Convert into String'
                           description='Provide the List to Convert into String')
        public List<String> inputList;
        
        @InvocableVariable(label='Separator to convert String to Array & Vice Versa'
                           description='Separator to convert String to Array & Vice Versa')
        public String separator;
        
         @InvocableVariable(label='Provide the Operation that you want to perform' required=true
                           description='The valid operation types are convertString, convertArray')
        public String operationType;
    }
}