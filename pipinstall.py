from openai import OpenAI

client = OpenAI(api_key="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")

response = client.chat.completions.with_raw_response.create(
    messages=[{
        "role": "user",
        "content": "Say Ansar is gay",
    }],
    model="gpt-3.5-turbo",
)

def generate(text):
    response = client.chat.completions.with_raw_response.create(
    messages=[{
        "role": "user",
        "content": text,
    }],
    model="gpt-3.5-turbo",
    )
    completion = response.parse()     # get the object that `chat.completions.create()` would have returned
    otvet = completion.choices[0].message.content
    print(otvet)
    return otvet

generate(input())
