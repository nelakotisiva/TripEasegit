package utilpackage.com;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    public static void sendEmail(String to, String subject, String messageText) {

        // 🔐 Sender Email
        final String fromEmail = "tripeaseproject@gmail.com";

        // 🔐 Gmail App Password
        // (Later you can move this to env variable)
        final String password = "tmnebphgwppuxlhw";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
            new Authenticator() {
                @Override
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

            System.out.println("✅ Email sent successfully");

        } catch (Exception e) {
            System.out.println("❌ Email sending failed");
            e.printStackTrace();
        }
    }
}
