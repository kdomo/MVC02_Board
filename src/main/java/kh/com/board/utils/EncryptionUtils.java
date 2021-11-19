package kh.com.board.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptionUtils {
	
	public static String getSHA512(String pw) {//SHA 512를 통해 비밀번호를 암호화해주는 메소드 생성
			MessageDigest md;
			try {
				md = MessageDigest.getInstance("SHA-512");//MessageDigest 클래스 인스턴스를 생성
				md.reset(); //인스턴스를 초기화
				md.update(pw.getBytes("utf8")); //변환할 데이터를 utf-8 바이트코드로 변환 후 인스턴스에 추가
				pw= String.format("%0128x", new BigInteger(1,md.digest()));
			} catch (Exception e) {
				e.printStackTrace();
			} 
			return pw;
	}
}
