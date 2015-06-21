require 'rake/clean'
require 'rake/testtask'
require 'yaml'

if  ENV['Target'] != nil
  target=ENV['Target']
end
if  ENV['Tags'] != nil
  tag=ENV['Tags']
end
if  ENV['Feature'] != nil
  feature=ENV['Feature']
end
task :default => [:runall ]


task :runall do
  target.split.each do |device|
    if(device == "Android")
      var = Dir.glob("*.apk")
      if tag != nil
        system("calabash-android run #{var[0]} --format html --out Android_Tag_#{tag}.html --format pretty Target=Android --tags #{tag}")
      elsif feature != nil
        system("calabash-android run #{var[0]} --format html --out Android_Feature_#{feature}.html --format pretty Target=Android features/#{feature}.feature --tags @Android")
      else
        system("calabash-android run #{var[0]} --format html --out AndroidReport.html --format pretty features/myaccount.feature features/about.feature features/payment.feature Target=Android")
      end
    elsif(device == "IOS")
      if tag != nil
        system("cucumber --format html --out IOS_Tag_#{tag}.html --format pretty Target=IOS --tags #{tag}")
      elsif feature != nil
        system("cucumber --format html --out IOS_Feature_#{feature}.html --format pretty Target=IOS features/#{feature}.feature")
      else
        system("cucumber --format html --out IOSReport.html --format pretty features/myaccount.feature features/about.feature features/payment.feature Target=IOS")
      end
    end
  end
end
