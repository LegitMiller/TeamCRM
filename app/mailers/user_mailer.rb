class UserMailer < ActionMailer::Base
  default :from => "vimenpe89@gmail.com"

  def welcome_email(profile)
    mail(:to => profile.email, :subject => 'Welcome to My Awesome Site')
  end

	def progression_record_email(efrom, eto, recordid, mychange, oldchange)
		@changetype = mychange
		@change = oldchange
		@record = Record.find(recordid)
		@eto = Profile.find(eto)
		@efrom = Profile.find(efrom)
	  mail(to: @record.email, subject: 'Progress was made on Your Loan, '+ @record.firstname + " " + @record.lastname + "!")
	end

	def progression_profile_email(efrom, eto, recordid, mychange, oldchange)
		@changetype = mychange
		@change = oldchange
		@record = Record.find(recordid)
		@eto = Profile.find(eto)
		@efrom = Profile.find(efrom)
	  mail(to: @eto.email, subject: 'Progress made on '+ @record.firstname + " " + @record.lastname)
	end

	def phase_record_email(efrom, eto, recordid, mychange, oldchange)
		@changetype = mychange
		@change = oldchange
		@record = Record.find(recordid)
		@eto = Profile.find(eto)
		@efrom = Profile.find(efrom)
	  mail(to: @record.email, subject: 'Progress was made on Your Loan, ' + "!")
	end

	def phase_profile_email(efrom, eto, recordid, mychange, oldchange)
		@changetype = mychange
		@change = oldchange
		@record = Record.find(recordid)
		@eto = Profile.find(eto)
		@efrom = Profile.find(efrom)
	  mail(to: @eto.email, subject: 'Progress made on '+ @record.firstname + " " + @record.lastname )
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
