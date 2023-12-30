package com.isiraadithya.greensupermarket.helpers;

import jakarta.servlet.http.Part;
import org.apache.tika.Tika;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class ImageValidation {
    public static final int DEFAULT_BUFFER_SIZE = 8192;

    public static boolean isSafe(Part imagePart){
        boolean isTmpFileSaved = false;
        File tmpFile = null;
        try {
            // Saving the file temporarily
            String tmpPath = System.getProperty("java.io.tmpdir") + File.separator + "/toSanitize";
            tmpFile = new File(tmpPath);
            copyInputStreamToFile(imagePart.getInputStream(), tmpFile);
            isTmpFileSaved = true;

            // Getting the file type
            Tika tika = new Tika();
            String fileType = tika.detect(tmpFile);

            // Deleting the file
            tmpFile.delete();

            // Returning true if the content type is image/*
            if (!fileType.startsWith("image/")){
                return false;
            }
            return true;
        } catch (Exception ignore){
            try {
                if (isTmpFileSaved){
                    tmpFile.delete();
                }
            } catch (SecurityException ex){

            }
            return false;
        }
    }

    private static void copyInputStreamToFile(InputStream inputStream, File file)
            throws IOException {

        // append = false
        try (FileOutputStream outputStream = new FileOutputStream(file, false)) {
            int read;
            byte[] bytes = new byte[DEFAULT_BUFFER_SIZE];
            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }

    }
}
