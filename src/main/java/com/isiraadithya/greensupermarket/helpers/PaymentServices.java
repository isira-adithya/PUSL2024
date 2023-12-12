package com.isiraadithya.greensupermarket.helpers;

import java.text.DecimalFormat;
import java.util.*;

import com.isiraadithya.greensupermarket.models.Order;
import com.isiraadithya.greensupermarket.models.OrderDetail;
import com.isiraadithya.greensupermarket.models.User;
import com.paypal.api.payments.*;
import com.paypal.base.rest.*;



/**
 *
 * @author sanid
 * Taken and modified from https://www.codejava.net/coding/how-to-integrate-paypal-payment-into-java-web-application
 */
public class PaymentServices {

    private static final String CLIENT_ID = System.getenv("PAYPAL_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("PAYPAL_SECRET_KEY");
    private static final String MODE = "sandbox";
    public static final double shippingCost = 20;
    public static final double tax = 3.99;

    private Order order;

    public void setOrder(Order order){
        this.order = order;
    }

    public static String formatPaymentValue(double input){
        DecimalFormat decimalFormat = new DecimalFormat("#.##");
        return decimalFormat.format(input);
    }

    public String authorizePayment()
            throws PayPalRESTException {

        Payer payer = getPayerInformation();
        RedirectUrls redirectUrls = getRedirectURLs();

        List<Transaction> listTransaction = getTransactionInformation(this.order);

        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction);
        requestPayment.setRedirectUrls(redirectUrls);
        requestPayment.setPayer(payer);
        requestPayment.setIntent("authorize");
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        Payment approvedPayment = requestPayment.create(apiContext);
        return getApprovalLink(approvedPayment);
    }

    private Payer getPayerInformation() {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        PayerInfo payerInfo = new PayerInfo();
        User user = User.findUserById(this.order.getUserId());
        payerInfo.setFirstName(user.getFirstname())
                .setLastName(user.getLastname())
                .setEmail(user.getEmail());
        payer.setPayerInfo(payerInfo);

        return payer;
    }

    private RedirectUrls getRedirectURLs() {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:9090/user/orders/");
        redirectUrls.setReturnUrl("http://localhost:9090/user/payments/review.jsp?orderid="+order.getOrderId());

        return redirectUrls;
    }

    private List<Transaction> getTransactionInformation(Order order) {

        Details details = new Details();
        details.setShipping(this.formatPaymentValue(shippingCost));
        details.setSubtotal(this.formatPaymentValue(order.getAmount()));
        details.setTax(this.formatPaymentValue(tax));

        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal(this.formatPaymentValue(shippingCost + tax + order.getAmount()));
        amount.setDetails(details);

        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription("Order ID " + order.getOrderId());

        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();

        for (int i = 0; i < order.getOrderDetails().size(); i++){
            OrderDetail orderDetail = order.getOrderDetails().get(i);
            Item item = new Item();
            double itemPrice = orderDetail.getSubTotal() / orderDetail.getQuantity();
            item.setCurrency("USD");
            item.setName(orderDetail.getProduct().getName());
            item.setPrice(this.formatPaymentValue(itemPrice));
            item.setQuantity(String.valueOf(orderDetail.getQuantity()));
            items.add(item);
        }

        itemList.setItems(items);
        transaction.setItemList(itemList);
        List<Transaction> listTransaction = new ArrayList<>();
        listTransaction.add(transaction);

        return listTransaction;

    }

    private String getApprovalLink(Payment approvedPayment) {
        List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;

        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();
                break;
            }
        }

        return approvalLink;

    }

    public Payment executePayment(String paymentId, String payerId)
            throws PayPalRESTException {
        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);

        Payment payment = new Payment().setId(paymentId);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

        return payment.execute(apiContext, paymentExecution);
    }

    public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(apiContext, paymentId);
    }

}