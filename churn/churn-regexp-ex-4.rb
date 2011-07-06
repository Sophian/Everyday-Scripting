
#name = "Bensaou, Sophian Tokio"

def rearrange(name)
  full_name = /(\w+), (\w+) (\w+)/.match(name)
  last_name = full_name[1]
  first_name = full_name[2]
  middle_name = full_name[3]
  middle_initial = /(\w)\w+/.match(middle_name)[1]
  "#{first_name} #{middle_initial}. #{last_name}"
end

