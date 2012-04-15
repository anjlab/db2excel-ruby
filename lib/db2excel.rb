require 'db2excel/version'
require 'open3'
require 'multi_json'

module Db2Excel

  def create options={}

    args = {
      "connectionUrl"    => options[:connection_url] || active_record_to_jdbc_url,
      "jdbcDriver"       => options[:jdbc_driver]    || active_record_to_jdbc_driver,
      "query"            => options[:query],
      "templateFilePath" => options[:template_path],
      "outputFilePath"   => options[:output_path],
      "dataSheetIndex"   => options[:data_sheet_index] || 0
    }

    java_options = options[:java_options] || "-Dfile.encoding=utf8 -Xms512m -Xmx512m -XX:MaxPermSize=256m"
    jar_path = File.join(File.dirname(__FILE__), "db2excel.jar")

    Open3.popen3("java #{java_options} -jar #{jar_path}") do |stdin, stdout, stderr, wait_thr|
      stdin.write MultiJson.encode(args)
      stdin.close
      exit_status = wait_thr.value
    end
  end

  def active_record_to_jdbc_url spec = ActiveRecord::Base.connection_config
    case spec[:adapter]
    when "postgresql"
      args = []
      if spec[:user]
        args << ["user", spec[:user]]
      end
      if spec[:password]
        args << ["password", spec[:password]]
      end

      args_str = ""
      if args.present?
        args_str = "?#{args.map {|p| "#{p[0]}=#{p[1]}"}.join("&")}"
      end

      "jdbc:postgresql://#{spec[:host]}/#{spec[:database]}#{args_str}"
    end
  end

  def active_record_to_jdbc_driver spec = ActiveRecord::Base.connection_config
    case spec[:adapter]
    when "postgresql"
      "org.postgresql.Driver"
    else
      "TODO: support others"
    end
  end

  extend self
end
