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

@WebServlet(name = "adminProductDelete", value = "/api/admin/products/delete")
@MultipartConfig()
public class AdminProductDelete extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = -1;

        try {
            if (req.getParameter("productId") == null){
                resp.setStatus(400);
                return;
            }

            // Parsing the value
            try {
                productId = Integer.parseInt(req.getParameter("productId"));
            } catch (NumberFormatException ex){
                resp.setStatus(400);
                return;
            }

            // Creating a new product
            Product product = Product.findProductById(productId);

            // Checking if the product is a valid product
            if (product.getProductId() != -1){
                product.deleteProduct();
            }

            resp.sendRedirect("/admin/products/?msg=Product Deleted Successfully");
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
