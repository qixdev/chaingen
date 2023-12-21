from flask import Flask, render_template, request, send_file
from openai import OpenAI
import subprocess
import shlex
from helpers.config import API_KEY


app = Flask(__name__)
client = OpenAI(api_key=API_KEY)
script_number=1



def readDefaultScript(filename):
    with open(filename) as f:
        script = f.readlines()
    return script

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
        return False


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/download', methods=['POST', 'GET'])
def download():
    if request.method == 'POST':
        global script_number
        script_number+=1
        user_prompt = request.form['prompt']
        iter=0
        while iter<3:
            iter+=1 
            response = client.chat.completions.with_raw_response.create(
            messages=[{
            "role": "system", 
            "content": "You generate single bash script for blockchain nodes deployment without printing other information because it will be easier for me to parse your response if there is no other information besides script."
            }, 
            {"role": "user", 
            "content": f"Write me bash script based on this documentation.{user_prompt}. Your scripts based on user's prompt and his desires, but you always should generate a single bash script. Your bash script should work on Windows, Linux and MacOS. You should download tools for deploying node using curl or wget. You should provide only script, no any instruction how to run it, just script, nothing else. User can provide documentation that can have bash commands directly and can have undirected operations that should be made with bash like \" create folder called X\" and you have to assemble that documentation into bash script. If user documentation doesn't have commands and instructions to include in bash script, find out what blockchain he wants and build a script yourself. Sample scripts for you Bitcoin:{readDefaultScript('./defscripts/bitcoin.sh')}; Ethereum: {readDefaultScript('./defscripts/ethereum.sh')}; Dogecoin: {readDefaultScript('./defscripts/dogecoin.sh')} Do not use dogecoind, use only dogecoin-qt; Litecoin: {readDefaultScript('./defscripts/litecoin.sh')}. If user's documentation contains that sample scripts, just it back, DON'T CHANGE IT. Provide script without ```bash ```"}],
            model="gpt-4-1106-preview",
            temperature=0.1,
            #seed=42,
            top_p=0.1
            )
            completion = response.parse()     # get the object that `chat.completions.create()` would have returned
            otvet = completion.choices[0].message.content
            print(otvet)
            escaped = shlex.quote(otvet)
            cmd = f"echo {escaped} > script{script_number}.sh"
            subprocess.run(cmd, shell=True)
            cmd = f"mv script{script_number}.sh genscripts/"
            subprocess.run(cmd, shell=True)
            subprocess.run("chmod +x *", shell=True)
            if run_script(f"./genscripts/script{script_number}.sh", 60):
                subprocess.run('pkill -f "$BITCOIN_INSTALL_DIR/bin/bitcoin-qt"', shell=True)
                subprocess.run('pkill -f "$DOGECOIN_INSTALL_DIR/bin/dogecoin-qt"', shell=True)
                subprocess.run('pkill -f "$LITECOIN_INSTALL_DIR/bin/litecoin-qt"', shell=True)
                subprocess.run('pkill -f /home/debyte/bin/dogecoind', shell=True)
                subprocess.run('pkill -f "$HOME/ethereum/geth"', shell=True)
                subprocess.run('pkill -f "$BITCOIN_INSTALL_DIR/bin/bitcoin-qt"', shell=True)
                print("checkwork")
                return render_template('download.html', status="otvet", iter=script_number)
                break
        return render_template('retry.html')
    elif request.method == 'GET':
        return render_template('download.html')
    else:
        return render_template('404.html')


@app.route(f'/download/script/<int:script_number>')
def download_script(script_number):
    path = f"./genscripts/script{script_number}.sh"
    return send_file(path, as_attachment=True)


@app.route('/about')
def about():
    return render_template('about.html')


@app.route('/contacts')
def contacts():
    return render_template('contacts.htmql')


@app.errorhandler(404) 
def not_found(e): 
    return render_template("404.html") 
    

if __name__ == '__main__':
    app.run(debug=True)