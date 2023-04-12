//<access modifier> class <class name>{}
//<access modifier> <access specifier>
public class Animal {
    
	// <access modifier> <DataType> <VariableName> = <Value>;
	// <access modifier> <DataType> <VariableName>;
	// by default access modifier will be private for any variable
    public String name = 'Max'; // String will always be withing Single Quotes
    //public Id recordId = 'Max683hghyerthg'; // ( 15 digit OR 18 Digit ) 0012w00001Pz63PAAR
    String accountId = '0012w00001Pz63PAAR'; // accountId ~= Id
    Integer age = 5;
    
    // declare & initialize
    public static final DECIMAL PI_VALUE = 3.144; 
    // declare
    public static final DECIMAL GRAVITY_VALUE;

    // Instance Variable OR Object Variable
    // Multiple time memory allocation depends upon no of objects
    
    // Class Variable
    public static String address = '123 Main Street'; // One time memory allocation
    
    // Instance/Object Methods
    // <Access Modifier> <Return Type> <Method Name> (<Optional Parameters>) {
    	// Method Body
	//}	
    public void helloWorld(){
        System.debug(' Welcome to the world of Salesforce! ');
        System.debug(' Name of the Dog is '+name);
        System.debug(age);
    }
    
    // Without paramtere
    public void speak(){
        // Animal dog = new Animal();
        add(10, 20);
        add('Amit', 'Singh');
        System.debug(name+' is Speaking'); // Max/Lucy is Speaking
        // DML 
        // Callout
    }
    
    // Method Name can be same
    // but parametere different OR parameter data types are different OR no of paramteres can be different
    public void add(String str, String str1){
        System.debug(str+' '+str1);
    }
    
    public Integer add(Integer a, Integer b, Integer c){
        return a + b + c; //
    }
    
    public String sayHello(String name){ // parameters
        // ; (to terminate the statement/line)
        String newAdress = '123 Main Street'; // Method Variables
        System.debug(' '+ newAdress);
        return 'Hello '+name;
        // this is comment
        /*
         * This is comment
         */ 
    }
    
    // Paramatarised Methods (With Parameters)
    public void add(Integer number1, Integer number2) {
        Integer sum = number1 + number2;
        //System.debug('Sum of the '+number1+' and '+number2+' is '+ sum);
        return;
        // we can not return value but we can use return statement
    }
    
    // ClassName.Methodname
    // Animal.greet();
    public static void greet(){
        System.debug('Hello there!');
    }
    
}