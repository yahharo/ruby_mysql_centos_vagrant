#
# Cookbook Name:: basic_app
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Setup DB
mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password 'password'
  action [:create, :start]
end


# for now only db.
