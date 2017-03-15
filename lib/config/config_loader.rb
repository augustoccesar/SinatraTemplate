APP_CONFIG = OpenStruct.new

Dir.glob("#{ROOT}/config/_initial/*.yml") do |file|
  key = file.scan(/(\w+).yml/)[0][0]
  hash = YAML.load_file(file)[ENVIRONMENT]
  APP_CONFIG.send("#{key}=", JSON.parse(hash.to_json, object_class: OpenStruct))
end

Dir.glob("#{ROOT}/config/**/*.yml").reject{ |f| File.fnmatch('**/_initial/*.yml', f) }.each do |file|
  key = file.scan(/(\w+).yml/)[0][0]
  hash = YAML.load_file(file)[ENVIRONMENT]
  APP_CONFIG.send("#{key}=", JSON.parse(hash.to_json, object_class: OpenStruct))
end