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
  dest = File.join(*[home, sub_dir, File.basename(file)].compact)
  dest
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

def install(file, sub_dir=nil)
  file = File.expand_path(file)
  if !!(file.to_s =~ /dotfiles/)
    file_name = File.basename(file.to_s)
    if system("ln -nsf #{file} #{destination(file, sub_dir)}")
      puts "  #{colorize('↪️ successfully symlinked', :green)} #{sub_dir} #{colorize(file_name, :white_bold)}"
    else
      puts "  #{colorize('❗️failed to symlinked', :red)} #{sub_dir} #{colorize(file_name, :white_bold)}"
    end
  elsif
    puts "  #{colorize('❕please execute command in', :red)} #{colorize('dotfiles/', :white_bold)}"
  end
end

def uninstall(file, sub_dir=nil)
  file = destination(File.expand_path(file), sub_dir)
  return puts "no file at #{file}" unless File.exist?(file)
  file_name = File.basename(file.to_s)
  if File.symlink?(file)
    # File.unlink(file)
    puts "  #{colorize('🚮removed symlink at', :green)} #{sub_dir} #{colorize(file_name, :white_bold)}"
  else
    puts "  #{colorize('❗️could not remove non-symlink at', :red)} #{sub_dir} #{colorize(file_name, :white_bold)}"
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

def setup_neovim
  FileUtils.ln_sf("#{home}/dotfiles/nvim", "#{home}/.config/nvim")
end

def setup_snippets
  FileUtils.ln_sf("#{home}/dotfiles/snippets", "#{home}/.config/snippets")
end

def setup_zshell
  omz_dir_name = '.oh-my-zsh'
  # check for updates, store local changes, fetch updates and add local changes
  if File.exist?("#{home}/#{omz_dir_name}")
    Dir.chdir("#{home}/#{omz_dir_name}")
    system("git stash")
    system("git pull --rebase")
    system("git stash pop")
  else
    Dir.chdir("#{home}")
    system("git clone https://github.com/ohmyzsh/ohmyzsh.git #{omz_dir_name}")
  end

  # ZSH additional custom config
  FileUtils.ln_sf("#{home}/dotfiles/zsh", "#{home}/.config/zsh")
end
#
################################################################################
# install all the dotfiles
get_dir_files(root).each do |file|
  black_list = ['nvim', 'snippets', 'install', 'uninstall', 'zsh', '.DS_Store']

  next if file =~ /~$/
  next if black_list.include?(file)
  uninstall? ? uninstall(file) : install(file)
end

setup_neovim
setup_snippets
setup_zshell
