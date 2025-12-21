package utilpackage.com;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class Bookingemail {
	private static final String FROM_EMAIL = "tripeaseproject@gmail.com";
    private static final String APP_PASSWORD = "tmnebphgwppuxlhw";

    public static void sendBookingConfirmation(
            String toEmail,
            int bookingId,
            String destination,
            int travellers,
            java.sql.Date travelDate) {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL));
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));
            msg.setSubject("Tour Booking Confirmation");

            String body =
                "Dear Customer,\n\n" +
                "Your booking is confirmed!\n\n" +
                "Booking ID: " + bookingId + "\n" +
                "Destination: " + destination + "\n" +
                "Travellers: " + travellers + "\n" +
                "Travel Date: " + travelDate + "\n\n" +
                "Thank you for booking with us.\n" +
                "Happy Journey!\n\n" +
                "TripEase Team";

            msg.setText(body);

            Transport.send(msg);

            System.out.println("### EMAIL SENT SUCCESSFULLY ###");

        } catch (Exception e) {
            System.out.println("### EMAIL FAILED ###");
            e.printStackTrace();
        }
    }
}
