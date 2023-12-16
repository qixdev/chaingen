from flask import Flask, render_template, request
from openai import OpenAI

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/download', methods=['POST', 'GET'])
def download():
    user_prompt = request.form['prompt']
    # client = OpenAI(api_key="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")
    # response = client.chat.completions.with_raw_response.create(
    # messages=[{
    #     "role": "user",
    #     "content": user_prompt,
    # }],
    # model="gpt-3.5-turbo",
    # )
    # completion = response.parse()     # get the object that `chat.completions.create()` would have returned
    # otvet = completion.choices[0].message.content
    # print(otvet)
    return render_template('download.html')

if __name__ == '__main__':
    app.run(debug=True)