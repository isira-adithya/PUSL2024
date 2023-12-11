package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.SMTP;

import javax.mail.Message;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Date;

public class Email {
    SMTP smtp;
    private String toEmail;
    private String subject;
    private String body;
    private final String fromEmail = "no_reply@em6718.greensupermarket.live";
    private final String fromName = "GreenSuperMarket";

    public Email(String toEmail, String emailSubject, String emailBody){
        this.toEmail = toEmail;
        this.subject = emailSubject;
        this.body = emailBody;
    }

    public void send(){
        try
        {
            smtp = new SMTP();
            MimeMessage msg = new MimeMessage(smtp.getSession());
            //set message headers
            msg.addHeader("Content-Type", "text/html; charset=UTF-8");
            msg.addHeader("format", "flowed");
            msg.addHeader("Content-Transfer-Encoding", "8bit");
            msg.setFrom(new InternetAddress(fromEmail, fromName));
            msg.setReplyTo(InternetAddress.parse(fromEmail, false));
            msg.setSubject(this.subject, "UTF-8");
            msg.setText(this.body, "UTF-8");
            msg.setSentDate(new Date());
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(this.toEmail, false));
            Transport.send(msg);
            System.out.println("Email Sent Successfully!!");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
