#!/usr/bin/ruby1.8
# An app for displaying one's resume

require 'rubygems'
require 'sinatra'
require 'less'
require 'rdiscount'
require 'maruku'

get '/' do
   title = "Dan Mayer's Resume"
   resume = RDiscount.new(File.read("resume.md"), :smart).to_html
   erubis :index, :locals => { :title => title, :resume => resume }
end

get '/style.css' do
   content_type 'text/css', :charset => 'utf-8'
   less :style
end

get '/latex' do
  content_type 'application/x-latex'
  doc = Maruku.new(File.read("resume.md"))
  doc.to_latex_document
end

get '/markdown' do
  content_type 'application/markdown'
  File.read("resume.md")
end