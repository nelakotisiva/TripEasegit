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

    // 🔐 Sender Email (TripEase official)
    private static final String FROM_EMAIL = "tripeaseproject@gmail.com";

    // 🔐 Gmail App Password
    // ⚠️ Later move this to environment variable
    private static final String APP_PASSWORD = "tmnebphgwppuxlhw";

    private static Session getSession() {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        return Session.getInstance(props,
            new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            });
    }

    // =============================
    // 📧 SEND PLAIN TEXT EMAIL
    // =============================
    public static void sendEmail(String to, String subject, String messageText) {

        try {
            Message message = new MimeMessage(getSession());
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to)
            );
            message.setSubject(subject);
            message.setText(messageText);

            Transport.send(message);

            System.out.println("✅ Email sent to: " + to);

        } catch (Exception e) {
            System.out.println("❌ Email sending failed");
            e.printStackTrace();
        }
    }

    // =============================
    // 📧 SEND HTML EMAIL (OPTIONAL)
    // =============================
    public static void sendHtmlEmail(String to, String subject, String htmlContent) {

        try {
            MimeMessage message = new MimeMessage(getSession());
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to)
            );
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);

            System.out.println("✅ HTML Email sent to: " + to);

        } catch (Exception e) {
            System.out.println("❌ HTML Email sending failed");
            e.printStackTrace();
        }
    }
}
