package com.isiraadithya.greensupermarket.helpers;

import java.security.SecureRandom;
import java.util.Base64;

public class RandomStringGenerator {
    public static byte[] generateRandomBytes(int length) {
        SecureRandom secureRandom = new SecureRandom();
        byte[] randomBytes = new byte[length];
        secureRandom.nextBytes(randomBytes);
        return randomBytes;
    }

    public static String convertBytesToString(byte[] bytes) {
        // Using Base64 encoding for simplicity
        return Base64.getEncoder().encodeToString(bytes);
    }

    public static String getRandomString(int length){
        return convertBytesToString(generateRandomBytes(length));
    }
}
