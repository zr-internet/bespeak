if Rails.env.development?
  Rails.logger = Le.new('cd16914d-c25a-4108-a8dd-1af9429f459f', debug: true)
else
  Rails.logger = Le.new('cd16914d-c25a-4108-a8dd-1af9429f459f')
end
