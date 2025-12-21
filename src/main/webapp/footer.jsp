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

    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">ABOUT TRIPEASE</h3>
      <div class="footer-content">
        About Us, Careers, Investor Relations, Sustainability,
        Press & Media, CSR Policy, Partner With Us,
        Advertise With Us, Holiday Franchise
      </div>
    </div>

    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">ABOUT THE SITE</h3>
      <div class="footer-content">
        Customer Support, Payment Security, Privacy Policy,
        Cookie Policy, User Agreement, Terms of Service,
        Cancellation & Refund Policy, Escalation Channel
      </div>
    </div>

    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">PRODUCT OFFERINGS</h3>
      <div class="footer-content">
        Flights, International Flights, Hotels, International Hotels,
        Homestays and Villas, Holiday Packages,
        Cab Booking, Bus Tickets, Train Tickets,
        Forex Card, Travel Insurance
      </div>
    </div>

    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">SUPPORT</h3>
      <div class="footer-content">
        Help Center, FAQs, Cancellation, Refund Status,
        Safety Guidelines, 24/7 Customer Support
      </div>
    </div>

    <div class="footer-section">
      <h3 onclick="toggleFooter(this)">CONTACT</h3>
      <div class="footer-content">
        Email: tripeaseproject@gmail.com <br>
        Phone: +91 80044 55555 <br>
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
