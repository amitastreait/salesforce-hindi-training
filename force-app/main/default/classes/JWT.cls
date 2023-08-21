public class JWT {
    
    public String iss 	{ get; set; }
    public String sub 	{ get; set; }
    public String aud 	{ get; set; }
    public Long exp 	{ get; set; }

    public JWT(String iss, String sub, String aud, Long exp){
        this.iss = iss;
        this.sub = sub;
        this.aud = aud;
        this.exp = exp;
    }
    
    private static final String JWT_HEADER = '{"alg":"RS256"}';
    
    public static String retrievePrivateKey(){
        ContentVersion base64Content = [SELECT VersionData FROM ContentVersion where Title='server' ORDER BY Title LIMIT 1];
        String keyContents = base64Content.VersionData.tostring();
        keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('\n', '');
        return keyContents;
    }
   	
    public static void run(){
        
        DateTime rightNow = System.now();
        rightNow = rightNow.addMinutes(3);
        Long expiry = rightNow.getTime();
        
        JWT jwt = new JWT(
         '3MVG9n_HvETGhr3COGSBZ2RGw0UCthndmDcWklbdHdn08L0Idmk3gMp8P7c6iNsTnhM_61ZuvP3rrAqOcpHi5',
         'sfdcpanther+hindi@gmail.com','https://login.salesforce.com', expiry
        );
        
        String base64UrlJWTHeader = base64UrlEncode( JWT_HEADER );
        String body = JSON.serialize(jwt);
        String base64UrlJWTClaims = base64UrlEncode( body );
        
        String combinedHeaderClaim = base64UrlJWTHeader+'.'+base64UrlJWTClaims;
        System.debug('combinedHeaderClaim \n '+combinedHeaderClaim);
        
        String jwtAssertion = shaSignPrivateKey(combinedHeaderClaim);
        System.debug('jwtstr \n '+ jwtAssertion);
        
        getAccessToken(jwtAssertion);
        
    }
    
    public static String shaSignPrivateKey(String combinedHeaderClaim){
        // base64Decode the Private key Content
        Blob privateKey = EncodingUtil.base64Decode( retrievePrivateKey() );
        // Sign the private Key using rsa-sha256 Algorithm
        Blob signature  = Crypto.sign('rsa-sha256', Blob.valueOf(combinedHeaderClaim), privateKey);
        // Add the signature into the assertion
        combinedHeaderClaim += '.' + SFDC_BASE64_URLENCODE(signature);  
        return combinedHeaderClaim;
    }
    
    public static String base64UrlEncode(String header){
        String base64UrlEncode = SFDC_BASE64_URLENCODE( Blob.valueOf(header) );
        return base64UrlEncode;
    }
    
    private static String SFDC_BASE64_URLENCODE(final Blob input){
        if(input == null) {
            return null;
        }
        return EncodingUtil.base64Encode(input)
            .replace('/', '_')
            .replace('+', '-')
            .replaceAll('=+$', '');
    }
    
    private static void getAccessToken(String assertionValue){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token?grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion='+assertionValue);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        String response = res.getBody();
    }
}