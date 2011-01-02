# Learn more: http://github.com/javan/whenever

#set :output, "catalog_cron.log"

job_type :runner,  "cd :path && script/rails runner -e :environment ':task'"

every 3.minutes do
   runner "Videofile.convert_all"
end