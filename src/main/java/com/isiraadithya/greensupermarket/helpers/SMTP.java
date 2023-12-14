package com.isiraadithya.greensupermarket.helpers;

import java.util.Properties;
import javax.mail.*;

// Taken from: https://www.digitalocean.com/community/tutorials/javamail-example-send-mail-in-java-smtp
public class SMTP {

    private Session session;
    public SMTP(){
        String username = "apikey";
        String password = System.getenv("SENDGRID_API_KEY");

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.sendgrid.net"); //SMTP Host
        props.put("mail.smtp.port", "587"); //TLS Port
        props.put("mail.smtp.auth", "true"); //enable authentication
        props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        };
        session = Session.getInstance(props, auth);
    }

    public Session getSession(){
        return session;
    }
}
