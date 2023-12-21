import subprocess
import shlex
import time

def run_script(script_path, timeout_seconds):
    try:
        default = subprocess.check_output(["netstat", "-tuln"])
        script_path_escaped = shlex.quote(script_path)
        command = f"bash {script_path_escaped}"
        process = subprocess.Popen(command, shell=True, executable="/bin/bash")
        process.communicate(timeout=timeout_seconds)

    except subprocess.TimeoutExpired:
        afterwards = subprocess.check_output(["netstat", "-tuln"])
        process.terminate()
        #nodestat = subprocess.check_output("./portcheck.sh")      
        return not (default == afterwards)
    except Exception as e:
        print(f"An error occurred: {e}")

timeout_seconds = 60
if __name__ == "__main__":
    run_script("./bitcoin.sh", timeout_seconds)
