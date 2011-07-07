
#name = "Bensaou, Sophian Tokio"

def rearrange(name)
  match = /(\w+), (\w+$|\w+\s\w+$)/.match(name)
  last_name = match[1]
  first_names = match[2].split(" ")
  first_name = first_names[0]
  middle_name = first_names[1]
  
  if middle_name.class == NilClass
    "#{first_name} #{last_name}"
    else "#{first_name} #{middle_name[0,1]}. #{last_name}"
  end

end

