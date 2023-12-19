import subprocess
import shlex
import time

def run_script(script_path, timeout_seconds):
    try:
        script_path_escaped = shlex.quote(script_path)
        command = f"bash {script_path_escaped}"
        process = subprocess.Popen(command, shell=True, executable="/bin/bash")
        process.communicate(timeout=timeout_seconds)

    except subprocess.TimeoutExpired:
        process.terminate()
        nodestat = subprocess.check_output("./portcheck.sh")        
        print(f"Script '{script_path}' exceeded the timeout of {timeout_seconds} seconds.")
        print(nodestat)
        print(nodestat == b'Node is up\n') # works  
    except Exception as e:
        print(f"An error occurred: {e}")

timeout_seconds = 60 
run_script("./bitcoin.sh", timeout_seconds)
