class SubversionRepository
  
  def initialize(root)
    @root = root
  end
  
  def date(a_time)
    a_time.strftime("%Y-%m-%d")
  end
  
  def change_count_for(name, start_date)
    extract_change_count_from(log(name, start_date))
  end
  
  def extract_change_count_from(log_text)
    lines = log_text.split("\n")
    dashed_lines = lines.find_all do |line|
      line.include?('-----')
    end
    dashed_lines.length - 1
  end
  
  def log(subsystem, start_date)
    timespan = "-revision 'HEAD:{#{start_date}}'"
    root = "svn://rubyforge.org//var/svn/churn-demo"
    
    'svn log #{timespan} #{@root}/#{subsystem}'
  end
end

if $0 == __FILE__
  subsystem_names = ['audit', 'fulfillment', 'persistence', 'ui', 'util', 'inventory']
  root="svn://rubyforge.org//var/svn/churn-demo"
  repository = SubversionRepository.new(root)
  start_date = repository.date(month_before(Time.now))
   
  puts header(start_date)
  lines = subsystem_names.collect do |name|
    subsystem_line(name, repository.change_count_for(name, start_date))
  end
  puts order_by_descending_change_count(lines)
end
