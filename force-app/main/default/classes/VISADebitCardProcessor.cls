public class VISADebitCardProcessor {

    // IPaymentProcessor processor - Generic
    public void processPayment(Decimal amount, IPaymentProcessor processor){
        // Run Time pe decide karega
        processor.processPayment(amount);
    }
    
}