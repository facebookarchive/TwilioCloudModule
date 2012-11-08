var twilio = require("twilio");
twilio.initialize("TWILIO_ACCOUNT_SID","TWILIO_AUTH_TOKEN");

Parse.Cloud.define("inviteWithTwilio", function(request, response) {
  twilio.sendSMS({
    From: "TWILIO_PHONE_NUMBER",
    To: request.params.number,
    Body: "Start using Parse and Twilio!"
  }, {
    success: function(httpResponse) {
      console.log(httpResponse);
      response.success("SMS sent!");
    },
    error: function(httpResponse) {
      console.error(httpResponse);
      response.error("Uh oh, something went wrong");
    }
  });
});

