package com.isiraadithya.greensupermarket.routes.admin.products;

import com.isiraadithya.greensupermarket.helpers.RandomStringGenerator;
import com.isiraadithya.greensupermarket.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet(name = "adminProductChangeVisibility", value = "/api/admin/products/change-visibility")
public class AdminProductChangeVisibility extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = -1;

        try {
            String[] verifyThese = {"productId"};
            for (int i = 0; i < verifyThese.length; i++){
                if (req.getParameter(verifyThese[i]) == null){
                    resp.setStatus(400);
                    return;
                }
            }

            // User Inputs
            productId = Integer.parseInt(req.getParameter("productId"));

            // Checking if the product
            Product product = Product.findProductById(productId);
            if (product.getProductId() != -1){
                if (product.getVisibility()){
                    product.setVisibility(false);
                } else {
                    product.setVisibility(true);
                }
                product.updateProduct();
                resp.sendRedirect("/admin/products/product.jsp?id=" + product.getProductId());
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
