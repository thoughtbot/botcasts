require "yaml"
require "open3"

def syscall(*cmd)
  stdout, _, status = Open3.capture3(*cmd)
  status.success? && stdout.slice!(0..-(1 + $/.size)) # strip trailing eol
rescue
end

repo_directory = ARGV.first
file = File.join(repo_directory, ".tags.yml")
raise "#{file} not found" unless File.exist?(file)

tags = YAML.load_file(file).each

commits = []

# Verify all commit messages exist in repo.
tags.each do |tag|
  commit = tag["commit"]
  Dir.chdir(repo_directory) do
    sha = syscall("git rev-parse :/\"#{commit}\"")
    if sha
      commits << {sha:, annotation: tag["tag"], message: tag["message"]}
    end
    raise "Commit with message '#{commit}' not found." unless sha
  end
end

# Delete all existing tags.
Dir.chdir(repo_directory) do
  syscall("git tag -d $(git tag -l)")
  syscall("git fetch --tags")
  syscall("git push origin --delete $(git tag -l)")
  syscall("git tag -d $(git tag -l)")
end

# Tag the commits.
Dir.chdir(repo_directory) do
  commits.each do |commit|
    if (message = commit[:message])
      syscall("git tag -a #{commit[:annotation]} #{commit[:sha]} -m '#{message}'")
    else
      syscall("git tag #{commit[:annotation]} #{commit[:sha]}")
    end
  end
end

# Push new tags.
Dir.chdir(repo_directory) do
  syscall("git push --tags")
end
