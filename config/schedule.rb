# Learn more: http://github.com/javan/whenever

#set :output, "catalog_cron.log"

every 5.minutes do
   runner "Videofile.convert_all"
end
