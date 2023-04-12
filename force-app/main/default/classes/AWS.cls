public virtual class AWS {
	//  AWS S3/EC2/Emails/Worflows/Lamda
	protected String serviceName;
    protected String regionName;
    protected String url;
    protected String accessKey;
    protected String accessSecret;
    public AWS(String serviceName, String regionName, String url, String accessKey, String accessSecret){
        
    }
    protected virtual void authenticate(){
        //
    }
}