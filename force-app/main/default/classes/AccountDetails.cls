public class AccountDetails {
    
    private String accountName;
    private Integer noOfEmployees;
    private AccountWrapper wrapper;
    // private Integer noOfEmployees { private get; private set; }
    
    public String rating  { get; private set; }
    public String typex   { private get; set; }
    public String partner { get; set; }
    public String phone;
    // public String phone { get; set; }
    // Publically accessible
    // Private Set (within class)
    
    public String getName(){
        return this.accountName;
    }
    
    public void setName(String name){
        this.accountName = name;
    }
    
    public Integer getEmployees(){
        return this.noOfEmployees;
    }
    
    public void setEmployees(Integer noOfEmployees){
        this.noOfEmployees = noOfEmployees;
    }
    
    public AccountWrapper getAccountWrapper(){
        return this.wrapper;
    }
    
    public void setAccountWrapper(AccountWrapper wrapper){
        this.wrapper = wrapper;
    }
    
    public void testWrapper(){
        AccountWrapper wrapper = new AccountWrapper();
        wrapper.accountName = 'United Oil & Gas Inc';
        System.debug(wrapper);
    }
    
    public class AccountWrapper {
        private String accountName;
        private Integer noOfEmployees;
        // Phone, Rating, Fax
        public void setaccountName(String name){
            this.accountName = name;
        }
        public void setnoOfEmployees(Integer noOfEmployees){
            this.noOfEmployees = noOfEmployees;
        }
    } 
    // Email - sfdcpanther@gmail.com
    // UserName - sfdcpanther@gmail.com.assignment1
    // UserName - sfdcpanther@gmail.com.assignment2
    
}