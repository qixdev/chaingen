from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/download', methods=['POST'])
def download():
    user_prompt = request.form['prompt']
    return render_template('download.html')


@app.route('/source-code')
def showsource():
    return render_template('download.html')

if __name__ == '__main__':
    app.run(debug=True)