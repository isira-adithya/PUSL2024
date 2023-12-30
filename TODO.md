# GreenSuperMarket - Online E-Commerce Website

### Todos
- [X] Add Styles (CSS, Bootstrap, etc)
- [X] Make File Uploads More Secure
- [X] Add / Load sample data to the database
  - [X] Add realistic product information
- [X] Add Contact Us Page (Not a static HTML page)
  - [X] Create database tables
  - [X] Create a Model
  - [X] Create API routes
  - [X] Finish the backend part
- [X] Add to WishList feature
  - [X] Create database tables
  - [X] Create a Model
  - [X] Create API routes
  - [X] Finish the backend part
- [X] Remove all the secrets / sensitive information from the code; Instead use environmental variables
- [X] Implement CSRF Protection *(Specially protect `/api/*`)*
- [X] Connect the system to a SMTP Server
  - [X] Send password reset emails
  - [X] Send order confirmation emails
  - [X] Send email verification emails (optional at the moment, but would be better)
  - [X] Send order cancellation emails
- [X] Add the PayPal sandbox integration
- [X] Add better Exceptional handling, Logging and Verbose Error messages for users to see.
- [X] Show random featured products for every user (should check the visibility of products)
- [X] Update the `Product.getProducts` function and add functionalities to filter products by visibility.
- [X] Finish the about us section of the website.
- [X] Fix the Signup page's form
- [X] Change roles in About us

## Sample Credentials For Payments
*Visit https://developer.paypal.com/tools/sandbox/card-testing/ to generate your own card.*
- Valid Card
  - Card Number: `5110929971155987`
  - Expiry Date: `05/27`
  - CVC: `971`