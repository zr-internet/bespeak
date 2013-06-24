How to Create Your Site in Bespeak
==================================

Creating a new site in Bespeak is fairly easy, but to get the most out of the system there are a few moving pieces you'll want to make sure you stay on top of. This tutorial will cover the entire process from start to finish.

Step 1 - Create a New Site
--------------------------
The first step to creating a new site is to actually create the site in the backend. To do that login to bespeak and click on the sites menu item. From there you'll see a table with all your existing sites. Over on the upper left you'll see the "New Site" button. That's the button you want. Click it.

**Congratulations! You've taken the first step.**

Step 2 - The New Site Form
--------------------------
At first glance the new site form may look a little overwhelming. There are countless fields to enter data into, and if you screw up some of them you may just find all of your money going to some random joker in Nunavit. But if you keep an even keel and follow these instructions closely, before long you'll have cash flowing into your bank account. Also remember, you don't have to enter all the information. You can add more details over time.

Here is the form: ![new site form](http://assets-bespeak.s3.amazonaws.com/docs/bespeak-new-site.png "New Site Form")

The first piece of information you'll want to enter is the site name. Enter that in the name field.
![new site name](http://assets-bespeak.s3.amazonaws.com/docs/bespeak-new-site-name.png "New Site Name")

Next you'll want to enter your Payment Processor details. Currently Bespeak only supports Authorize.NET but we'll support additional payment processors in the future.

![new site payment processor](http://assets-bespeak.s3.amazonaws.com/docs/bespeak-new-site-payment-processor.png "New Site Payment Processor")

You can find your Authorize.NET API Login ID and API Key within the Authorize.NET interface.

Now that you've got your site named and payments can come through you should save your work so far. Go ahead and click "Create Site" at the bottom of the form.

Step 3 - Setting Up Emails
--------------------------
Bespeak uses your [Mandrill](http://mandrillapp.com) account to send out confirmation and reminder emails.

Once you've logged into Mandrill you'll want to record your api key, you can find this under the settings menu on the top right (click the gear icon, then select SMTP & API Credentials).

![Accessing the API Credentials](http://assets-bespeak.s3.amazonaws.com/docs/bespeak-new-site-mandrill-api-key.png "Accessing the API Credentials")

From the SMTP & API Credentials Page you'll need to create a new API Key, simply click on the New API Key button fill in the description with the name of your site, and then copy the generated key to a convenient location so you can paste it into Bespeak later. The API Key allows Bespeak to communicate with Mandrill and instruct Mandrill to send emails.

The next step is to create the emails you want to send. To get up and running quickly we'll focus on the confirmation email.

The confirmation email is sent to customers after they have successfully booked a course. To create your confirmation email in Mandrill go to the Outbound menu and select Templates:

![Templates in the Outbound Menu](http://assets-bespeak.s3.amazonaws.com/docs/bespeak-new-site-mandrill-outbound-menu.png)

Next click the "Create a Template" button, name your template SITE-NAME Booking Confirmation and click "Start Coding"

Now you can build your confirmation email - you have access to the following placeholders: 
* *|COURSE_NAME|*
* *|OFFICE_NAME|*
*	*|COURSE_START|*
* *|OFFICE_ADDRESS|*
* *|OFFICE_DIRECTIONS|*

![Example confirmation email](http://assets-bespeak.s3.amazonaws.com/docs/bespeak-new-site-mandrill-example-email.png)

Once you are happy with your email copy the template slug and keep it with the API Key you copied earlier.

Now go back to Bespeak, edit the site you are creating, and fill in the email details (use whatever you want for the name) and save your site.

Step 4 - Set Up Offices
-----------------------
Now that you have your emails set up it is time to scheduling courses, but before you do that we need to create offices and course types. First we create offices.

From the site page click on offices in the right hand bar and then click "Create a New Office" and fill in the office details. Lather, rinse, and repeat until you have all your offices created.

Step 5 - Create Course Types
----------------------------
Now we to create the course types that people can sign up for. This process is very straight forward and basically works the same as creating a new office.

Step 6 - Schedule Courses
-------------------------
You guys already know how to do this.

Step 7 - Get the Bespeak Code Installed on Your Site
----------------------------------------------------
Crowdvert can handle this.




