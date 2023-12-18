from flask import Flask, render_template, request, send_file
from openai import OpenAI
import subprocess
import shlex

app = Flask(__name__)
client = OpenAI(api_key="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")
script_number=1


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/download', methods=['POST', 'GET'])
def download():
    if request.method == 'POST':
        global script_number
        script_number+=1
        user_prompt = request.form['prompt']
        # script = """
        # echo "Blockchain was created"
        # """
        # initial = f"""I need a ready-made bash script created according to this documentation for deploying a node on my computer: {user_prompt}. If you need tools in the provided documentation, enter their installation in the script if the operating system is Linux. If not, then print that they are not installed. If there are no scripts in the submitted documentation, change this script to meet the criteria of the documentation: {script}. Provide only scripts itself, because I am going to write your response to bash file and your text can cause error."""
        # response = client.chat.completions.with_raw_response.create(
        # messages=[{
        #     "role": "user",
        #     "content": initial,
        # }],
        # model="gpt-4",
        # )
        # completion = response.parse()
        # otvet = completion.choices[0].message.content
        # print(otvet)
        # escaped = shlex.quote(otvet)
        # cmd = f"echo {escaped} > script.sh"
        # subprocess.run(cmd, shell=True)
        return render_template('download.html', status="otvet", iter=script_number)
    elif request.method == 'GET':
        return render_template('download.html')
    else:
        print("asdfasdf")


@app.route(f'/download/script/<int:script_number>')
def download_script(script_number):
    path = f"scripts/script{script_number}.sh"
    return send_file(path, as_attachment=True)


@app.route('/about')
def about():
    return render_template('about.html')


@app.route('/contacts')
def contacts():
    return render_template('contacts.html')


@app.errorhandler(404) 
def not_found(e): 
    return render_template("404.html") 
    

if __name__ == '__main__':
    app.run(debug=True)