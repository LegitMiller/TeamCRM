module MessgsHelper

  def returnsend(mystring)  	
    if mystring.blank?
      nil
    else
      if mystring == "false"
        nil
      else mystring == "true"
        "send"
      end
    end
  end
end
