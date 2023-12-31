package com.isiraadithya.greensupermarket.routes.admin.products;

import com.isiraadithya.greensupermarket.helpers.ImageValidation;
import com.isiraadithya.greensupermarket.helpers.RandomStringGenerator;
import com.isiraadithya.greensupermarket.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.awt.*;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "adminProductAdd", value = "/api/admin/products/add")
@MultipartConfig()
public class AdminProductAdd extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productName = "";
        String productDescription = "";
        String productShortDescription = "";
        double productPrice = -1;
        int productQuantity = -1;
        boolean productVisibility = false;

        try {
            String[] verifyThese = {"productName","productDescription","productPrice","productQuantity","productShortDescription"};
            for (int i = 0; i < verifyThese.length; i++){
                if (req.getParameter(verifyThese[i]) == null){
                    resp.setStatus(400);
                    return;
                }
            }

            // User Inputs
            productQuantity = Integer.parseInt(req.getParameter("productQuantity"));
            productPrice = Double.parseDouble(req.getParameter("productPrice"));
            productName = req.getParameter("productName");
            productDescription = req.getParameter("productDescription");
            productShortDescription = req.getParameter("productShortDescription");


            if (req.getPart("imageFile") == null){
                resp.setStatus(400);
                resp.sendRedirect("/admin/products/");
            }

            // Creating a new product
            Product product = new Product(productName, productShortDescription, productDescription, "NULL", productPrice, productQuantity, productVisibility);

            // Let's make sure that the dir is accessible
            String productImageUploadDirPath = req.getServletContext().getRealPath("/uploads/images/products/");
            File productImageUploadDir = new File(productImageUploadDirPath);
            if (!productImageUploadDir.exists()){
                try {
                    productImageUploadDir.mkdirs();
                } catch (SecurityException ex){
                    System.out.println("Please fix directory permissions");
                    return;
                }
            }

            Part imagePart = req.getPart("imageFile");
            // Checking if it is secure
            if (!ImageValidation.isSafe(imagePart)){
                resp.setStatus(403);
                return;
            }

            String imageName = RandomStringGenerator.getRandomString(16) + "_" + imagePart.getSubmittedFileName();
            product.setImage(imageName);
            imagePart.write(productImageUploadDirPath + File.separator + imageName);

            product.saveProduct();
            resp.sendRedirect("/admin/products/");
            return;

        } catch (NumberFormatException err){
            resp.setStatus(400);
            return;
        } catch (Exception err){
            resp.setStatus(500);
            return;
        }
    }
}
