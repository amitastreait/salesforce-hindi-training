public class CallStackDemo {

    public void methodA(){
        System.debug('Inside Method A');
        System.debug('Inside Method A1');
        System.debug('Inside Method A1');
        methodB();
        System.debug('A');
    }
    public void methodB(){
        System.debug('Inside Method B');
        String methodCOutput = methodC(); // Method Call
        System.debug('B \n '+ methodCOutput);
    }
    public String methodC(){
        methodD(); // Method
        System.debug('C');
        return 'Hello I\'m from method C';
    }
    public void methodD(){
        methodE();
        System.debug('D');
    }
    public void methodE(){
        System.debug('E');
    }
}