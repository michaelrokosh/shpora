namespace :heroku do
  task import: :environment do
    puts 'Importing data from heroku...'

    puts 'Making pg backup...'
    sh 'heroku pg:backups capture --app shpora'

    puts 'Downloading backup...'
    sh 'curl -o latest.dump `heroku pg:backups public-url --app shpora`'

    puts 'Restoring backup...'
    sh 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -d shpora_development latest.dump'
  end
end
