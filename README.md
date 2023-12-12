# GreenSuperMarket - Online E-Commerce Website

### *Todos*
- [ ] Add Styles (CSS, Bootstrap, etc)
- [ ] Add Contact Us Page (Not a static HTML page)
- [ ] Connect the Cart Model to the database (with minimal database calls)
- [ ] Remove all the secrets / sensitive information from the code; Instead use environmental variables
- [ ] Implement CSRF Protection *(Specially protect `/api/*`)*
- [X] Connect the system to a SMTP Server
  - [X] Send password reset emails
  - [ ] Send order confirmation emails
  - [ ] Send email verification emails (optional at the moment, but would be better)
- [X] Add the PayPal sandbox integration
- [ ] Add better Exceptional handling, Logging and Verbose Error messages for users to see.

## Sample Credentials For Payments
- Valid Card
  - Card Number: `4032037377560418`
  - Expiry Date: `Any`
  - CVC: `Any`
- 3DS Card
  - Card Number (Visa): `4868 7194 6070 7704`
  - Card Number (Mastercard): `5329 8797 8623 4393`
  - Expiry Date: `01/2025`
  - CVC: `123`