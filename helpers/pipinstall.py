from openai import OpenAI

client = OpenAI(api_key="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")

# response = client.chat.completions.with_raw_response.create(
#     messages=[{
#         "role": "user",
#         "content": "Say Ansar is gay",
#     }],
#     model="gpt-3.5-turbo",
# )

def generate(text):
    #script = ""
    #initial = f"""I want you to generate bash script out of this documentation: {text}. Provide installing all tools if they're not installed on computer if it's linux or mac, or provide error message if it's windows or other. If documentation has no commands to include in bash script, configure this script to be exact as documentation describes: {script}"""
    response = client.chat.completions.with_raw_response.create(
    messages=[{
        "role": "user",
        "content": text,
    }],
    model="gpt-4-1106-preview",
    )
    completion = response.parse()     # get the object that `chat.completions.create()` would have returned
    otvet = completion.choices[0].message.content
    print(otvet)
    return otvet

while True:
    generate(input())
