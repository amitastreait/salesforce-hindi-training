public class S3Service extends AWS {
	public S3Service(String serviceName, String regionName, String url, String accessKey, String accessSecret){
        super(serviceName,regionName,url,accessKey,accessSecret);
    }
}