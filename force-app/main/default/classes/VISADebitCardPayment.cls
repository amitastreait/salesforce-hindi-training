public class VISADebitCardPayment implements IPaymentProcessor {
    // VISA
    // AMEX
    // MasterCard
    public void processPayment(Decimal amount){
        System.debug(' VISADebitCardPayment => '+ amount); 
    }
    public void processRefund(Decimal amount, Boolean isFullRefund){
        
    }
}