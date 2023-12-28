# GreenSuperMarket - Online E-Commerce Website

### *Todos*
- [X] Add Styles (CSS, Bootstrap, etc)
  - [ ] Add Styles to the order confirmation email
- [ ] Make File Uploads More Secure
- [X] Add / Load sample data to the database
  - [ ] Add realistic product information
- [X] Add Contact Us Page (Not a static HTML page)
  - [ ] Create database tables
  - [ ] Create a Model
  - [ ] Create API routes
  - [ ] Finish the backend part
- [X] Add to WishList feature
  - [ ] Create database tables
  - [ ] Create a Model
  - [ ] Create API routes
  - [ ] Finish the backend part
- [ ] Connect the Cart Model to the database (with minimal database calls)
  - [X] Abandoned
- [X] Remove all the secrets / sensitive information from the code; Instead use environmental variables
- [X] Implement CSRF Protection *(Specially protect `/api/*`)*
- [X] Connect the system to a SMTP Server
  - [X] Send password reset emails
  - [X] Send order confirmation emails
  - [X] Send email verification emails (optional at the moment, but would be better)
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