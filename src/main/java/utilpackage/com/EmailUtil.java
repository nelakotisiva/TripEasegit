package utilpackage.com;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    private static final String FROM_EMAIL = "sathvikspdg@gmail.com";
    private static final String APP_PASSWORD = "ulmp ctdi bpld qjge"; // Gmail App Password
    private static final String ADMIN_EMAIL = "sathvikspdg@gmail.com";

    public static void sendBookingMail(
            String userName,
            String userEmail,
            String cabModel,
            String seater,
            String location,
            double price) {

        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(ADMIN_EMAIL));
            msg.setSubject("🚕 New Cab Booking | TripEase");

            String body =
                    "New Cab Booking Details\n\n" +
                    "User Name: " + userName + "\n" +
                    "User Email: " + userEmail + "\n" +
                    "Cab Model: " + cabModel + "\n" +
                    "Seater Type: " + seater + "\n" +
                    "Location: " + location + "\n" +
                    "Price Per Day: ₹" + price + "\n\n" +
                    "Regards,\nTripEase System";

            msg.setText(body);

            Transport.send(msg);
            System.out.println("✅ Booking Email Sent to Admin");

        } catch (Exception e) {
            System.out.println("❌ Email Sending Failed");
            e.printStackTrace();
        }
    }
}
