# GreenSuperMarket - Online E-Commerce Website

### *Todos*
- [ ] Add Styles (CSS, Bootstrap, etc)
  - [ ] Add Styles to the order confirmation email
- [ ] Make File Uploads More Secure
- [ ] Add / Load sample data to the database
- [X] Add Contact Us Page (Not a static HTML page)
  - [ ] Finish the backend part
- [X] Add to WishList feature
  - [ ] Finish the backend part
- [ ] Connect the Cart Model to the database (with minimal database calls)
- [X] Remove all the secrets / sensitive information from the code; Instead use environmental variables
- [ ] Implement CSRF Protection *(Specially protect `/api/*`)*
- [X] Connect the system to a SMTP Server
  - [X] Send password reset emails
  - [X] Send order confirmation emails
  - [ ] Send email verification emails (optional at the moment, but would be better)
- [X] Add the PayPal sandbox integration
- [ ] Add better Exceptional handling, Logging and Verbose Error messages for users to see.
- [ ] Show random featured products for every user (should check the visibility of products)
- [ ] Update the `Product.getProducts` function and add functionalities to filter products by visibility.
- [ ] Finish the about us section of the website.

## Sample Credentials For Payments
*Visit https://developer.paypal.com/tools/sandbox/card-testing/ to generate your own card.*
- Valid Card
  - Card Number: `5110929971155987`
  - Expiry Date: `05/27`
  - CVC: `971`