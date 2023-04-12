public class CustomerDiscount implements IPurchaseOrder {
    public Contact customer;
    public Decimal discount(){
        DateTime oneYearOld = System.now().addYears(-1);
        DateTime twoYearOld = System.now().addYears(-2); 
        if( this.customer.CreatedDate > oneYearOld ){
            return 2.3;
        }else if( this.customer.CreatedDate > twoYearOld ){
            return 4.5;
        }
        return 1.6;
    }
}