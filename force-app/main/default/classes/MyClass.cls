public class MyClass {

    static String name = 'Apple Company';
    static {
        System.debug('Static block executed '+name);
        // Country - State
        // Country - Currency
        // Interface - Object
    }
    
    {
       // Instance Block 
       System.debug('Instance Block Executed');
    }
    
    public MyClass(){
        System.debug('Constructor Executed');
    }
    
    // 10
    // 12
    // 167
}