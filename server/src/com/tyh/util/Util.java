package com.tyh.util;

import java.io.IOException;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

import javax.crypto.Cipher;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Util {

	/**
     * base64加密
     * @param decoderBase64
     * @return
     * @author wxd
     */
    public static String encoderBASE64(String decoderBase64){
    	if( decoderBase64 !=null){
	   		 BASE64Encoder base64Encoder = new BASE64Encoder();
	   		 return base64Encoder.encode(decoderBase64.getBytes());
	   	}else{
	   		 throw new IllegalArgumentException("uibs.invalid_client_cert");
	   	}
    }
    /**
     *  @将BASE64编码的字符串进行解码为字符串
     *  @param encorderBase64  BASE64编码的字符串
     *  @author wxd
     */
    public static String decoderBASE64ToString(String encorderBase64) {
    	return new String(decoderBASE64(encorderBase64));
    }
    /**
     *
     * @param encorderBase64
     * @return BASE64编码解码后的二进制编码
     * @author wxd
     */
    public static byte[] decoderBASE64(String encorderBase64) {
    	 if( encorderBase64 !=null){
    		 BASE64Decoder base64Decoder = new BASE64Decoder();
    		 try {
				return base64Decoder.decodeBuffer(encorderBase64);
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
    	 }else{
    		 throw new IllegalArgumentException("uibs.invalid_client_cert");
    	 }
    }
    
    //将base64编码后的公钥字符串转成PublicKey实例  
    public static PublicKey getPublicKey(String publicKey) throws Exception{  
        byte[ ] keyBytes=Base64.getDecoder().decode(publicKey.getBytes());  
        X509EncodedKeySpec keySpec=new X509EncodedKeySpec(keyBytes);  
        KeyFactory keyFactory=KeyFactory.getInstance("RSA");  
        return keyFactory.generatePublic(keySpec);    
    }  
      
    //将base64编码后的私钥字符串转成PrivateKey实例  
    public static PrivateKey getPrivateKey(String privateKey) throws Exception{  
        byte[ ] keyBytes=Base64.getDecoder().decode(privateKey.getBytes());  
        PKCS8EncodedKeySpec keySpec=new PKCS8EncodedKeySpec(keyBytes);  
        KeyFactory keyFactory=KeyFactory.getInstance("RSA");  
        return keyFactory.generatePrivate(keySpec);  
    }  
      
    //公钥加密  
    public static byte[] encrypt(byte[] content, PublicKey publicKey) throws Exception{  
        Cipher cipher=Cipher.getInstance("RSA");//java默认"RSA"="RSA/ECB/PKCS1Padding"  
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);  
        return cipher.doFinal(content);  
    }  
      
    //私钥解密  
    public static byte[] decrypt(byte[] content, PrivateKey privateKey) throws Exception{  
        Cipher cipher=Cipher.getInstance("RSA");  
        cipher.init(Cipher.DECRYPT_MODE, privateKey);  
        return cipher.doFinal(content);  
    }
    
    
    
    
    
    
    
    
    /**
    *
    * @param encorderBase64
    * @return BASE64编码解码后的二进制编码
    * @author wxd
     * @throws Exception 
    */
    public static void main(String[] args) throws Exception {
		String a="这是一个加密字符串";
		String a1=encoderBASE64(a);
		System.out.println("加密后====="+a1);
		System.out.println("解密后====="+decoderBASE64ToString(a1));
		  String data=a;  
	      String publicKeyString="MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCISLP98M/56HexX/9FDM8iuIEQozy6kn2JMcbZS5/BhJ+U4PZIChJfggYlWnd8NWn4BYr2kxxyO8Qgvc8rpRZCkN0OSLqLgZGmNvoSlDw80UXq90ZsVHDTOHuSFHw8Bv//B4evUNJBB8g9tpVxr6P5EJ6FMoR/kY2dVFQCQM4+5QIDAQAB";  
	      String privateKeyString="MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAIhIs/3wz/nod7Ff/0UMzyK4gRCjPLqSfYkxxtlLn8GEn5Tg9kgKEl+CBiVad3w1afgFivaTHHI7xCC9zyulFkKQ3Q5IuouBkaY2+hKUPDzRRer3RmxUcNM4e5IUfDwG//8Hh69Q0kEHyD22lXGvo/kQnoUyhH+RjZ1UVAJAzj7lAgMBAAECgYAVh26vsggY0Yl/Asw/qztZn837w93HF3cvYiaokxLErl/LVBJz5OtsHQ09f2IaxBFedfmy5CB9R0W/aly851JxrI8WAkx2W2FNllzhha01fmlNlOSumoiRF++JcbsAjDcrcIiR8eSVNuB6ymBCrx/FqhdX3+t/VUbSAFXYT9tsgQJBALsHurnovZS1qjCTl6pkNS0V5qio88SzYP7lzgq0eYGlvfupdlLX8/MrSdi4DherMTcutUcaTzgQU20uAI0EMyECQQC6il1Kdkw8Peeb0JZMHbs+cMCsbGATiAt4pfo1b/i9/BO0QnRgDqYcjt3J9Ux22dPYbDpDtMjMRNrAKFb4BJdFAkBMrdWTZOVc88IL2mcC98SJcII5wdL3YSeyOZto7icmzUH/zLFzM5CTsLq8/HDiqVArNJ4jwZia/q6Fg6e8KO2hAkB0EK1VLF/ox7e5GkK533Hmuu8XGWN6I5bHnbYd06qYQyTbbtHMBrFSaY4UH91Qwd3u9gAWqoCZoGnfT/o03V5lAkBqq8jZd2lHifey+9cf1hsHD5WQbjJKPPIb57CK08hn7vUlX5ePJ02Q8AhdZKETaW+EsqJWpNgsu5wPqsy2UynO";  
	 
		
		//获取公钥   
        PublicKey publicKey=getPublicKey(publicKeyString);  
         System.out.println("publicKey==================="+publicKey.toString()); 
        //获取私钥   
        PrivateKey privateKey=getPrivateKey(privateKeyString);        
        System.out.println("publicKey===================="+privateKey.toString()); 

        //公钥加密  
        byte[] encryptedBytes=encrypt(data.getBytes(), publicKey);    
        System.out.println("加密后："+new String(encryptedBytes));  
          
        //私钥解密  
        byte[] decryptedBytes=decrypt(encryptedBytes, privateKey);        
        System.out.println("解密后："+new String(decryptedBytes));  
	}
}
