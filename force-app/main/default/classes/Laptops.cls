public class Laptops {
    /* Instance Variable / Object Variable */
    public String companyName; // default value ~= null
    public Boolean isAdult; // default value ~= null
    public String processor;
    public Integer ramSize;
    
    /* Class Variable / Static Variable */
    public static String name;
    /*
    public Laptops(){
    }
    */
    // Account acc = new Account(Name ='Test Account');
    // Account acc = new Account(Name ='Test Account', Industry='Education');
    public Laptops(Integer ramSize){
        this.ramSize = ramSize;
        // this.ClassVariableName = <constructor parameter name>
    }
    public Laptops(String companyName){
        System.debug('Company Name in constructor is =>'+ companyName);
        this.companyName = companyName;
        // this.ClassVariableName = <constructor parameter name>
    }
    public Laptops(String companyName, String processor){
        System.debug('Company Name in constructor is =>'+ companyName);
        this.companyName = companyName;
        this.processor = processor;
    }
    public Laptops(String companyName, String processor, Integer ramSize){
        System.debug('Company Name in constructor is =>'+ companyName);
        this.companyName = companyName;
        this.processor = processor;
        this.ramSize = ramSize;
    }
    
    public void listAllLaptops(){
       // SOQL
    }
    // Instance Method / Object Method
    public void printCompanyName(){
        
        System.debug(' Company Name withing printCompanyName method is => '+ companyName);
        System.debug(' Company Name withing printCompanyName method is => '+ name);
        
        if(companyName != null){
            
            System.debug(' Company Name withing printName method is => '+ name);
            // SOQL - SELECT ID, Name, ----- FROM Laptop__c WHERE Company_Name = ''
            
        } else if( companyName != null && processor != null ){ // && = AND, || = OR 
            
            System.debug(' companyName withing printName method is => '+ companyName);
            System.debug(' processor withing printName method is => '+ processor);
            // SOQL - SELECT ID, Name, ----- FROM Laptop__c WHERE Company_Name = '' AND Processor__c = ''
             
        } else if(companyName != null && processor != null && ramSize != null){
            
            System.debug(' companyName withing printName method is => '+ companyName);
            System.debug(' processor withing printName method is => '+ processor);
            System.debug(' ramSize withing printName method is => '+ ramSize);
            // SOQL - SELECT ID, Name, ----- FROM Laptop__c WHERE Company_Name = '' AND Processor__c = '' AND RAM_SIZE__c = 784;
             
        } else if(companyName != null || processor != null || ramSize != null){
            
            //
            
        } else {
            
        }
    }
    // Class Method / Static Methods
    public static void printName(){
        // Static Variable/Class Variable
        
    }
    
}