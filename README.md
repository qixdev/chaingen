# Astana IT University: Blockchain Hack 2023 

## Project name

__Chaingen__

## Selected problem

__LLM-generated blockchain node deployment script__

## Team name

__DNA__

## Participants

* Danial Baitakov. Email: 230408@astanait.edu.kz
* Nurlan Kurmetov. Email: 230383@astanait.edu.kz
* Ansar Shangilov. Email: 230720@astanait.edu.kz

## Abstract

ChainGen streamlines blockchain node deployment through AI, simplifying the process for users.

## Demo video

[Link to a demo video showcasing your project, if any. Ensure it is less than 3 minutes long.]

## How to run

### Prerequisites:

- Python 3.11
- Flask 2.3.3

All other needed libraries are included in `requirements.txt`

### Running

Basic example:
```bash
# Clone the repository
git clone https://github.com/qixdev/chaingen.git

# Navigate to the project directory
cd chaingen

# Install all dependencies
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r requirements.txt

# Setup your api key
# Create a file called .env
nano .env
# Write you api key like this: "API_KEY=[YOUR OPENAI API KEY]

# Run the application
python app.py
```

## Inspirations

Our main inspiration was having experience of useful programs that can be deployed and used worldwide. We were inspired by the website called privacy.sexy, that generates scripts for keeping yourself private.
[Explain the inspirations behind your project. What motivated your team to work on this idea?]

## Technology stack and organization

Our team consists of 3 members: Danial, Nurlan, Ansar -> that's why team called DNA.
    - Danial is the captain of the team that is responsible for backend, connection with LLM and management.
    - Nurlan is designer of our team and he is responsible for design of our website.
    - Ansar is the most experienced in blockchain in our team. He is responsible for creating default bashscripts and contibuting to prompting LLM.
Although, there is selected responsobilities, there was no bound in helping to each other, we did everything together but to a different extent.
As our main part is website, we've used Python and it's very known framework - Flask
For LLM standing behind of generating scripts we've used ChatGPT-4-turbo, that can process up to 128k tokens.


## Solutions and features implemented

We developed a website, where user can type his request or documenation and get the script, behind this process there is a prompting a LLM which is chatGPT and checking the final script of the user. So checking was the hardest and easiest to solve at the same time. Our captain constructed a script that checks if node is running by checking used ports before executing the script at server machine. After that program executes generated script and again checks for used ports. If 1st check result doesn't equals to 2nd, then node is running successfully. Another solution would be parsing of the output of the script and matching it with regex, searching for "ERROR", or something like that. 
[Provide a detailed description of the solutions and features your team implemented. Include images if applicable. This section should be around 200-250 words.]

## Challenges faced

Project itself was simple, but not easy. We faced many challenges, starting from simple `pip install` going to checking that node is running. The hardest challenge was to optimize LLM's prompts to give correct scripts as even GPT-4 was limited by it's knowledge about deploying nodes, and also one of the hardest challenge was checking of running of the node, but it appeared to be solved easily. 

## Lessons learned

As our team wasn't really specified on this field, we've learned a lot about blockchain. There was very big experience exchange in team, teammates learned bash, python's flask library, default blockchain tools. We've learned about connecting openai api to project, we hadn't any experience on this.

## Future work

Project can be reimplemented using new technologies like Docker and Golang for faster deployment and use. ChainGen can be optimized for faster use. New frontend technologies can be used, such as React, Angular for better appearance. Project can be hosted worldwidely. Default checkboxes can be added to project for default scripts, like bitcoin, ethereum, and the most popular blockchains.

## Additional sources

[Include links to any additional sources of useful information that could benefit others interested in your project.]
