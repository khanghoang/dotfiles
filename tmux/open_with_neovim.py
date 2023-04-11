#!/usr/local/bin/python3
import re
import subprocess
import sys

file_path = sys.argv[1] # first arg is the script itself

pattern = re.compile(".*?(\/code\/server\/.*?)(?::(\d+)(?:\.html)?)?$")
match = pattern.match(file_path)

file_path_with_line_number = ''
line_number = 0

if match:
    file_path_with_line_number = match.group(1)
    file_path_with_line_number = '{}{}'.format("/Users/khang", file_path_with_line_number)
    line_number = match.group(2)
    if line_number:
        print(f"File path with line number: {file_path_with_line_number}:{line_number}")
    else:
        print(f"File path without line number: {file_path_with_line_number}")
else:
    print("No match.")

assert file_path_with_line_number

# open in the new tab
subprocess.run(['/usr/local/bin/nvr', '--remote-tab', file_path_with_line_number, '-c', str(line_number)])

# switch to window 2
subprocess.run(["/usr/local/bin/tmux", "select-window", "-t", "2"])

# bring kitty to front
app_name = "kitty"
script = f'tell application "System Events" to set frontmost of process "{app_name}" to true'
subprocess.run(['osascript', '-e', script])
