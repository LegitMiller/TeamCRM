class UserMailer < ActionMailer::Base
  helper MailerHelper
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

end
