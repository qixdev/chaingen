from openai import OpenAI
from config import API_KEY
client = OpenAI(api_key=API_KEY)




# response = client.chat.completions.with_raw_response.create(
#     messages=[{
#         "role": "user",
#         "content": "Say Ansar is gay",
#     }],
#     model="gpt-3.5-turbo",
# )

# params = {
#     'model': 'text-davinci-003',
#     'temperature': 0.8,           
#     'max_tokens': 100,            
#     'seed': 42,                   
#     'top_p': 0.7                  
# }
def readDefaultScript(filename):
    with open(filename) as f:
        script = f.readlines()
    return script



def generate(text):
    #script = ""
    #initial = f"""I want you to generate bash script out of this documentation: {text}. Provide installing all tools if they're not installed on computer if it's linux or mac, or provide error message if it's windows or other. If documentation has no commands to include in bash script, configure this script to be exact as documentation describes: {script}"""
    response = client.chat.completions.with_raw_response.create(
    messages=[{
        "role": "system", 
        "content": "You generate single bash script for blockchain nodes deployment without printing other information because it will be easier for me to parse your response if there is no other information besides script."
        }, 
#"You are AI that stands behind service called \"ChainGen\" that generates bash scripts for blockchain nodes deployment. Your scripts based on user's prompt and his desires, but you always should generate a single bash script. Your bash script should work on Windows, Linux and MacOS. You should download tools for deploying node using curl or wget and use latest version of tools. You should provide only script, no any instruction how to run it, just script, nothing else. User can provide documentation that can have bash commands directly and can have undirected operations that should be made with bash like \" create folder called X\" and you have to assemble that documentation into bash script.
        {"role": "user", 
        "content": f"{text}. Your scripts based on user's prompt and his desires, but you always should generate a single bash script. Your bash script should work on Windows, Linux and MacOS. You should download tools for deploying node using curl or wget and use latest version of tools. You should provide only script, no any instruction how to run it, just script, nothing else. User can provide documentation that can have bash commands directly and can have undirected operations that should be made with bash like \" create folder called X\" and you have to assemble that documentation into bash script. Sample script for you {readDefaultScript('./defscripts/bitcoin.sh')}"}],
    model="gpt-4-1106-preview",
    temperature=0.1,
    #seed=42,
    top_p=0.1
    )
    completion = response.parse()     # get the object that `chat.completions.create()` would have returned
    otvet = completion.choices[0].message.content
    print(otvet)
    return otvet

if __name__ == '__main__':
    while True:
        generate(input())
