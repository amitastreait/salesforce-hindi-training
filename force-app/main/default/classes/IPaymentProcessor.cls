public interface IPaymentProcessor {
    void processPayment(Decimal amount);
    void processRefund(Decimal amount, Boolean isFullRefund);
}