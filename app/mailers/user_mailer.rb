class UserMailer < ActionMailer::Base
  helper MailerHelper
  #require "restclient"  
  default :from => "shadrak.kay@gmail.com"

  def welcome_email(profile)
    mail(:to => profile.email, :subject => 'Welcome to My Awesome Site')
  end

	def record_email(efrom, eto, recordid, mychange, oldchange)
		@changetype = mychange
		@change = oldchange
		@record = Record.find(recordid)
		@eto = Profile.find(eto)
		@efrom = Profile.find(efrom)
	  mail(to: @record.email, subject: 'Progress was made on Your Loan, ' + @record.firstname + "!")
	end

	def profile_email(efrom, eto, recordid, mychange, oldchange)
		@changetype = mychange
		@change = oldchange
		@record = Record.find(recordid)
		@eto = Profile.find(eto)
		@efrom = Profile.find(efrom)
	  mail(to: @eto.email, subject: 'Record changed: '+ @record.firstname + " " + @record.lastname )
	end

	def send_simple_message
	  RestClient.post "https://api:key-b60921c9cf56556674d5741dc09de536"\
	  "@api.mailgun.net/v3/sandboxa8ea094b71f240bbadecf69c14fe8456.mailgun.org/messages",
	  :from => "SuperiorLendingCRM <postmaster@sandboxa8ea094b71f240bbadecf69c14fe8456.mailgun.org>",
	  :to => "Jordan Miller <jordan.kay@gmail.com>",
	  :subject => "Hello John Johnson",
	  :text => "Congratulations John Johnson, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
	end

	def send_simple(name, address, subject, message)
		if !address.blank? && !name.blank? && !subject.blank? && !message.blank? && address =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
		  RestClient.post "https://api:key-b60921c9cf56556674d5741dc09de536"\
		  "@api.mailgun.net/v3/sandboxa8ea094b71f240bbadecf69c14fe8456.mailgun.org/messages",
		  :from => "SuperiorLendingCRM <postmaster@sandboxa8ea094b71f240bbadecf69c14fe8456.mailgun.org>",
		  :to => name + " <" + address + ">",
		  :subject => subject,
		  :text => message
	  end
	end
end
