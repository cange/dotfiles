#!/usr/bin/env ruby

require 'fileutils'
# require 'colorize'

EXCLUDES = %w(. .. .git .gitignore .oh-my-zsh bin README.md install)

def cwd
  @cwd ||= File.expand_path(File.dirname(__FILE__))
end

def root
  File.dirname(cwd)
end

def home
  @home ||= File.expand_path('~')
end

def destination(file, sub_dir)
  desti = File.join(*[home, sub_dir, File.basename(file)].compact)
  desti
end

def colorize(text, color=:default)
  colors = {
    :default    => "\033[30m",
    :red        => "\033[31m",
    :green      => "\033[32m",
    :yellow     => "\033[33m",
    :white_bold => "\033[1;38m"
  }

  "#{colors[color]}#{text}\033[0m"
end


def message(msg, file_name, success=true)
  if success
    puts "#{@color_green}#{msg}#{@color_default} - #{@color_white_bold}#{file_name}#{@color_default}"
  else
    puts "#{@color_yellow}#{msg}#{@color_default} - #{@color_white_bold}#{file_name}#{@color_default}"
  end
end

def install(file, sub_dir=nil)
  file = File.expand_path(file)
  if !!(file.to_s =~ /dotfiles/)
    file_name = File.basename(file.to_s)
    if system("ln -nsf #{file} #{destination(file, sub_dir)}")
      puts "#{colorize('successfully symlinked', :green)} #{sub_dir} #{colorize(file_name, :white_bold)}"
    else
      puts "#{colorize('failed to symlinked', :red)} #{sub_dir} #{colorize(file_name, :white_bold)}"
    end
  elsif
    puts "#{colorize('please execute this file into this directory', :red)} #{colorize('dotfiles/', :white_bold)}"
  end
end

def uninstall(file, sub_dir=nil)
  file = destination(File.expand_path(file), sub_dir)
  return puts "no file at #{file}" unless File.exist?(file)
  file_name = File.basename(file.to_s)
  if File.symlink?(file)
    File.unlink(file)
    puts "#{colorize('removed symlink at', :green)} #{sub_dir} #{colorize(file_name, :white_bold)}"
  else
    puts "#{colorize('could not remove non-symlink at', :red)} #{sub_dir} #{colorize(file_name, :white_bold)}"
  end
end

def uninstall?
  ARGV.include?('-u')
end

def get_dir_files(path)
  Dir.entries(path) - EXCLUDES
end

if ARGV.include?('-h')
  script = File.basename(__FILE__)
  puts %[
  "#{script}" symlinks the files in dotmatrix into your home directory.
  options:
      -h  Get this help
      -u  Remove symlinks to files in dotmatrix
  ]
  exit 0
end

def install_shell_framework(framework_name)
  # check for updates, store local changes, fetch updates and add local changes
  if File.exist?("#{home}/.#{framework_name}")
    Dir.chdir("#{home}/.#{framework_name}")
    system("git stash")
    system("git pull --rebase")
    system("git stash pop")
  else
    Dir.chdir("#{home}")
    system("git clone git://github.com/robbyrussell/oh-my-zsh.git .#{framework_name}")
  end
  # travel back to dotfiles/ directory
  Dir.chdir("#{home}/dotfiles")

  get_dir_files(File.join(root, "#{framework_name}")).each do |dir|
    framework_path = "#{framework_name}/#{File.basename(dir)}"
    destination_path = ".#{framework_path}"
    get_dir_files(File.join(root, "#{framework_name}/#{dir}")).each do |file|
      install("#{framework_path}/#{file}", destination_path)
    end
  end
end

def install_terminal_config
  sub_dir              = ".config"
  terminal_path        = "#{home}/#{sub_dir}/terminator"
  terminal_backup_path = "#{terminal_path}-backup"
  terminal_new_path    = "terminator"

  if File.exist?(terminal_path) && !File.symlink?(terminal_path)
    system("mv -f #{terminal_path} #{terminal_backup_path}")
    puts "#{colorize('created backup', :green)} #{colorize(terminal_backup_path, :white_bold)}"
    install(terminal_new_path, sub_dir)
  else
    FileUtils.ln_sf "#{ home }/dotfiles/#{ terminal_new_path }", "#{ home }/#{ sub_dir }/#{ terminal_new_path }"
    puts "#{colorize('successfully symlinked', :green)} #{sub_dir} #{colorize('terminator', :white_bold)}"
  end
end
#
################################################################################
# install all the dotfiles
get_dir_files(root).each do |file|
  next if file =~ /~$/
  uninstall? ? uninstall(file) : install(file)
end

install_terminal_config
install_shell_framework('oh-my-zsh')
