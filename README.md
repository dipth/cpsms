[![Gem Version](https://badge.fury.io/rb/cpsms.svg)](http://badge.fury.io/rb/cpsms)
[![Build Status](https://circleci.com/gh/dipth/cpsms/tree/master.svg?style=shield)](https://circleci.com/gh/dipth/cpsms/tree/master)

# CPSMS

A wrapper for the cpsms.dk API.

It will allow you to easily send SMS messages through the API from your Ruby applications.

# Prerequisites

To use the API you need to have an account on cpsms.dk

Once you have the account, you should have the following information:

* username
* password

You will need this information for all calls to the API.

# Sending an sms

To send an sms simply call the ```CPSMS::SMS.send!``` method

The method takes the following parameters

* **username**: Your cpsms.dk username (*string*)
* **password**: Your spsms.dk password (*string*)
* **recipient**: The phone-number of the recipient (*integer*)
* **message**: The message to send to the recipient (*string - max 459 chars*)
* **options**: A hash of optional options (described below)

To send a basic sms with the message: "Hello world" to 12345678

    CPSMS::SMS.send! "username", "password", 12345678, "Hello World!"

You can pass a hash of optional options to the method. The possible options and their defaults are as follows

* **from**: A number or string that will be displayed as the sender of the message (*string - max 11 chars*)
* **url**: A callback url that CPSMS will call with details about the delivery. (See CPSMS's API documentation for more info) (*string - max 100 chars*)
* **timestamp**: A timestamp that specifies when the sms should be sent. (*Time*)
* **flash**: If set to true, the sms will be sent as a flash-sms (*boolean*)
* **group**: Currently not implemented

# Testing

To create new tests or edit existing you need to set your cpsms.dk credentials and a valid mobile number as environment variables.

More specifically you need to set these three environment variables with their respective values:

* CPSMS_USERNAME
* CPSMS_PASSWORD
* CPSMS_MOBILE_NUMBER

If you're using RVM, you can copy the supplied ```.rvmrc_example``` file to ```.rvmrc``` and edit the last two lines with your credentials

    export CPSMS_USERNAME=YourUsername
    export CPSMS_PASSWORD=YourPassword
    export CPSMS_MOBILE_NUMBER=YourMobileNumber

**Please note:** Your mobile number must be prepended with the country-code, for instance: 4512345678 for a danish number (45).

By doing this, the variables will automatically be set when RVM sets the environment.

If you just wish to run the existing test suite, you don't need to set these values, as VCR will simply use existing recordings for communication with the API.
