#!ruby
require 'optparse'
require 'yaml'
require_relative 'lib/bayonetta.rb'
include Bayonetta

$options = {
  decode: false,
  decode_frame: nil
}

OptionParser.new do |opts|
  opts.banner = "Usage: mot_tool.rb target_file [options]"
  opts.on("--[no-]decode", "Decode motion file") { |decode|
    $options[:decode] = decode
  }

  opts.on("--decode-frame=FRAME_INDEX", "Decode a motion frame") { |decode_frame|
    $options[:decode_frame] = decode_frame.to_i
  }

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end

end.parse!

Dir.mkdir("mot_output") unless Dir.exist?("mot_output")
input_file = ARGV[0]
raise "Invalid file #{input_file}" unless File::file?(input_file)

mot = MOTFile::load(input_file)

puts YAML::dump(mot.decode) if $options[:decode]
puts YAML::dump(mot.decode_frame($options[:decode_frame])) if $options[:decode_frame]