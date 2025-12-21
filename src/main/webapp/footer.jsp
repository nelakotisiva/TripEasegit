<%@ page contentType="text/html;charset=UTF-8" %>

<style>
/* ===== FOOTER STYLES ===== */
.footer {
  background-color: #000;
  color: #ccc;
  padding: 40px 20px;
  font-family: Arial, sans-serif;
}

.footer-container {
  max-width: 1200px;
  margin: auto;
}

.footer-section {
  border-bottom: 1px solid #222;
  padding: 15px 0;
}

.footer-section h3 {
  color: #00aaff;
  cursor: pointer;
  font-size: 15px;
  margin-bottom: 8px;
  user-select: none;
}

.footer-section h3:hover {
  color: #1ec6ff;
}

.footer-content {
  display: none;
  font-size: 14px;
  line-height: 1.8;
  color: #aaa;
}

.footer-content a {
  color: #aaa;
  text-decoration: none;
}

.footer-content a:hover {
  color: #1ec6ff;
  text-decoration: underline;
}

.footer-content.show {
  display: block;
}

.footer-copy {
  text-align: center;
  font-size: 12px;
  color: #666;
  margin-top: 30px;
}
</style>

<!-- ===== FOOTER HTML ===== -->
<footer class="footer">
  <div class="footer-container">

    <!-- ABOUT TRIPEASE -->
    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">ABOUT TRIPEASE</h3>
      <div class="footer-content">
        <a href="info.jsp#about">About Us</a>, 
        <a href="info.jsp#careers">Careers</a>, 
        <a href="info.jsp#investors">Investor Relations</a>, 
        <a href="info.jsp#sustainability">Sustainability</a>, 
        <a href="info.jsp#press">Press & Media</a>, 
        <a href="info.jsp#csr">CSR Policy</a>, 
        <a href="info.jsp#partners">Partner With Us</a>, 
        <a href="info.jsp#advertise">Advertise With Us</a>, 
        <a href="info.jsp#franchise">Holiday Franchise</a>
      </div>
    </div>

    <!-- ABOUT THE SITE -->
    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">ABOUT THE SITE</h3>
      <div class="footer-content">
        <a href="info.jsp#support">Customer Support</a>, 
        <a href="info.jsp#security">Payment Security</a>, 
        <a href="info.jsp#privacy">Privacy Policy</a>, 
        <a href="info.jsp#cookies">Cookie Policy</a>, 
        <a href="info.jsp#terms">User Agreement</a>, 
        <a href="info.jsp#terms">Terms of Service</a>, 
        <a href="info.jsp#cancellation">Cancellation & Refund Policy</a>, 
        <a href="info.jsp#escalation">Escalation Channel</a>
      </div>
    </div>

    <!-- PRODUCT OFFERINGS -->
    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">PRODUCT OFFERINGS</h3>
      <div class="footer-content">
        Flights, International Flights, Hotels, International Hotels,
        Homestays and Villas, Holiday Packages,
        Cab Booking, Bus Tickets, Train Tickets,
        Forex Card, Travel Insurance
      </div>
    </div>

    <!-- SUPPORT -->
    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">SUPPORT</h3>
      <div class="footer-content">
        <a href="info.jsp#help">Help Center</a>, 
        <a href="info.jsp#faq">FAQs</a>, 
        <a href="info.jsp#cancellation">Cancellation</a>, 
        <a href="info.jsp#refund">Refund Status</a>, 
        <a href="info.jsp#guidelines">Safety Guidelines</a>, 
        <a href="info.jsp#support">24/7 Customer Support</a>
      </div>
    </div>

    <!-- CONTACT -->
    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">CONTACT</h3>
      <div class="footer-content">
        Email: <a href="mailto:tripeaseproject@gmail.com">tripeaseproject@gmail.com</a><br>
        Phone: <a href="tel:+918004455555">+91 80044 55555</a><br>
        Bengaluru, India
      </div>
    </div>

  </div>

  <div class="footer-copy">
    © 2025 TRIPEASE GLOBAL PARTNERS PVT LTD. ALL RIGHTS RESERVED.
  </div>
</footer>

<script>
function toggleFooter(element) {
  element.nextElementSibling.classList.toggle("show");
}
</script>
