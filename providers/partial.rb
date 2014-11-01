# for instances where a config file can't be completely managed by chef, think
# /etc/modules (which might differ per machine), or whatever stupid situation
# might warrant having this


action :commit do

  def sanitize(string)
    string.gsub(/\.|\\|\/|\?\#/, '-')
  end

  temp_path             = ::Dir.mktmpdir
  delimiter             = new_resource.delimiter or sanitize(new_resource.source)
  comment_prefix        = new_resource.comment_prefix
  temp_file_destination = "#{::File.join(temp_path, sanitize(new_resource.source))}"
  start_delim           = "#{comment_prefix} #{delimiter}-START"
  end_delim             = "#{comment_prefix} #{delimiter}-END"

  directory temp_path do
    recursive true
    action    :create
  end

  execute "clean up from previous partial run on #{new_resource.target_file}" do
    command "sed '#{start_delim}/,/#{end_delim}/d' > #{new_resource.target_file}"
  end

  template temp_file_destination do
    source new_resource.source
  end

  execute "wedge in changes to #{new_resource.target_file} from #{new_resource.source}" do
    command "echo #{start_delim} >> #{new_resource.target_file}"
    command "cat #{temp_file_destination} >> #{new_resource.target_file}"
    command "echo #{end_delim} >> #{new_resource.target_file}"
  end
end
