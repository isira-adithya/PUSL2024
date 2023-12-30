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

@WebServlet(name = "adminProductUpdate", value = "/api/admin/products/update")
@MultipartConfig()
public class AdminProductUpdate extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productName = "";
        String productDescription = "";
        String productShortDescription = "";
        double productPrice = -1;
        int productQuantity = -1;
        int productId = -1;
        boolean shouldUpdateImage = false;

        try {
            String[] verifyThese = {"productName","productDescription","productPrice","productQuantity","productId","productShortDescription"};
            for (int i = 0; i < verifyThese.length; i++){
                if (req.getParameter(verifyThese[i]) == null){
                    resp.setStatus(400);
                    return;
                }
            }

            // User Inputs
            productId = Integer.parseInt(req.getParameter("productId"));
            productQuantity = Integer.parseInt(req.getParameter("productQuantity"));
            productPrice = Double.parseDouble(req.getParameter("productPrice"));
            productName = req.getParameter("productName");
            productDescription = req.getParameter("productDescription");
            productShortDescription = req.getParameter("productShortDescription");

            if (req.getPart("imageFile").getSize() != 0){
                shouldUpdateImage = true;
            }

            // Checking if the product
            Product product = Product.findProductById(productId);
            if (product.getProductId() != -1){
                product.setName(productName);
                product.setDescription(productDescription);
                product.setShortDescription(productShortDescription);
                product.setPrice(productPrice);
                product.setProductQuantity(productQuantity);


                // Image Upload Handling
                if (shouldUpdateImage){
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
                    boolean isSafe = ImageValidation.isSafe(imagePart);
                    if (!isSafe){
                        resp.setStatus(403);
                        return;
                    }

                    String imageName = RandomStringGenerator.getRandomString(16) + "_" + imagePart.getSubmittedFileName();
                    product.setImage(imageName);
                    imagePart.write(productImageUploadDirPath + File.separator + imageName);
                }

                product.updateProduct();
                resp.sendRedirect("/admin/products/");
                return;
            } else {
                resp.setStatus(400);
                return;
            }

        } catch (NumberFormatException err){
            resp.setStatus(400);
            return;
        } catch (Exception err){
            resp.setStatus(500);
            return;
        }
    }
}
