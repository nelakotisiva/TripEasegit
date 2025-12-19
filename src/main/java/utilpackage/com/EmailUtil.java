package utilpackage.com;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {

    public static void sendEmail(String to, String subject, String messageText) {

        // 🔐 YOUR EMAIL
        final String fromEmail = "tripeaseproject@gmail.com";

        // 🔐 READ APP PASSWORD FROM ENV VARIABLE
        final String password = "tmnebphgwppuxlhw";


        if (password == null) {
            System.out.println("❌ EMAIL PASSWORD NOT FOUND IN ENV VARIABLES");
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to)
            );
            message.setSubject(subject);
            message.setText(messageText);

            Transport.send(message);
            System.out.println("✅ Email Sent Successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
